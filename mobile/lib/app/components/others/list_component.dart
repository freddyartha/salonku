import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/common/reusable_statics.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/extension/theme_extension.dart';

class ListComponentController<T> {
  Future<Success<List<T>>> Function(int pageIndex) getDataResult;
  final T Function(dynamic e) fromDynamic;
  late Function(VoidCallback fn) setState;

  final _listViewController = ScrollController();
  final List<T> _items = [];

  ListComponentController({
    required this.getDataResult,
    required this.fromDynamic,
  });

  bool _loadingBottom = false;
  bool _isItemRefresh = true;
  int _pageIndex = 1;
  int _maxPage = 0;

  void clear() {
    _items.clear();
    _pageIndex = 1;
    _maxPage = 0;
  }

  Future refresh() async {
    clear();
    await _refreshBottom();
    setState(() {});
  }

  Future _refreshBottom({nextPage = false}) async {
    final itemsX = await _getItems(nextPage: nextPage);
    if (!nextPage) _items.clear();
    _items.addAll(itemsX);
  }

  Future<List<T>> _getItems({nextPage = false}) async {
    if (!nextPage) {
      setState(() {
        _isItemRefresh = true;
      });
    }

    final pageIndexX = nextPage ? _pageIndex + 1 : _pageIndex;
    final res = await getDataResult(pageIndexX);
    if (res.meta != null) {
      _maxPage = res.meta!.lastPage;
      _pageIndex = res.meta!.currentPage;
    }
    List<T> resultData = [];
    resultData.addAll(res.data);
    setState(() {
      _isItemRefresh = false;
    });
    return resultData;
  }

  void init(Function(VoidCallback fn) setStateX, BuildContext context) {
    setState = setStateX;
    _listViewController.addListener(() async {
      if (_listViewController.position.userScrollDirection !=
          ScrollDirection.idle) {
        FocusScope.of(context).unfocus();
      }
      if (_loadingBottom) return;
      final maxScroll = _listViewController.position.maxScrollExtent;
      final currentScroll = _listViewController.position.pixels;
      const delta = 0.0;
      if (maxScroll - currentScroll <= delta && _pageIndex != _maxPage) {
        _loadingBottom = true;
        await _refreshBottom(nextPage: true);
        _loadingBottom = false;
      }
    });

    refresh();
  }
}

class ListComponent<T> extends StatefulWidget {
  final ListComponentController<T> controller;
  final Widget Function(T e) itemBuilder;
  final List<Widget>? loadingChildren;
  final Widget? customEmptyWidget;
  final bool withPadding;
  final Widget? customLoadingChildren;
  final bool withSeparator;
  final dynamic Function(T e)? editAction;
  final dynamic Function(T e)? deleteAction;

  const ListComponent({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.loadingChildren,
    this.customEmptyWidget,
    this.withPadding = true,
    this.customLoadingChildren,
    this.withSeparator = false,
    this.editAction,
    this.deleteAction,
  });

  @override
  State<ListComponent<T>> createState() => _ListComponentState<T>();
}

class _ListComponentState<T> extends State<ListComponent<T>> {
  @override
  void initState() {
    widget.controller.init((fn) {
      if (mounted) {
        setState(fn);
      }
    }, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double paddingValue = widget.withPadding ? 10.0 : 0.0;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          top: paddingValue,
          left: paddingValue,
          right: paddingValue,
        ),
        child: ReusableStatics.refreshIndicator(
          onRefresh: widget.controller.refresh,
          child: widget.controller._isItemRefresh
              ? widget.customLoadingChildren != null
                    ? widget.customLoadingChildren!
                    : ReusableWidgets.listLoadingWidget(
                        count: 5,
                        height: 100,
                        children: widget.loadingChildren,
                      )
              : widget.controller._items.isEmpty &&
                    !widget.controller._isItemRefresh
              ? widget.customEmptyWidget != null
                    ? widget.customEmptyWidget!
                    : ReusableWidgets.generalNotFoundWidget(
                        width: MediaQuery.of(context).size.width * 0.7,
                      )
              : ListView.separated(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.zero,
                  itemCount: widget.controller._items.length,
                  controller: widget.controller._listViewController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => widget.withSeparator
                      ? Divider(height: 1.5, thickness: 0.5)
                      : SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    if (index == widget.controller._items.length) {
                      return Visibility(
                        visible:
                            widget.controller._pageIndex !=
                                widget.controller._maxPage &&
                            widget.controller._items.isNotEmpty,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    } else {
                      if (widget.editAction == null &&
                          widget.deleteAction == null) {
                        return widget.itemBuilder(
                          widget.controller._items[index],
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            color: context.accent2.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.all(
                              Radius.circular(Radiuses.large),
                            ),
                            border: Border.all(color: context.contrast),
                          ),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                                if (widget.editAction != null) ...[
                                  SlidableAction(
                                    onPressed: (_) {
                                      widget.editAction!(
                                        widget.controller._items[index],
                                      );
                                    },
                                    backgroundColor: context.contrast,
                                    foregroundColor: AppColors.darkText,
                                    icon: Icons.edit,
                                    label: 'edit'.tr,
                                    borderRadius: widget.deleteAction == null
                                        ? BorderRadius.only(
                                            topRight: Radius.circular(
                                              Radiuses.large,
                                            ),
                                            bottomRight: Radius.circular(
                                              Radiuses.large,
                                            ),
                                          )
                                        : BorderRadius.zero,
                                  ),
                                ],
                                if (widget.deleteAction != null) ...[
                                  SlidableAction(
                                    onPressed: (_) {
                                      widget.deleteAction!(
                                        widget.controller._items[index],
                                      );
                                    },
                                    backgroundColor: AppColors.danger,
                                    foregroundColor: AppColors.darkText,
                                    icon: Icons.delete,
                                    label: 'delete'.tr,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(Radiuses.large),
                                      bottomRight: Radius.circular(
                                        Radiuses.large,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            child: widget.itemBuilder(
                              widget.controller._items[index],
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
        ),
      ),
    );
  }
}
