<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<jsp:include page="../layout/page_head.jsp" />

<jsp:include page="../layout/content_navbar_admin.jsp" />

<div class="container">
    <h1>分类管理
        <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#addCategoryDialog">
            <span class="glyphicon glyphicon-plus"></span>
        </button>
    </h1>
    <div class="alert alert-info fade in" role="alert"><span class="glyphicon glyphicon-time"></span> 正在加载分类信息...</div>
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>编号</th>
                    <th>分类名称</th>
                    <th>创建时间</th>
                    <th>修改时间</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody id="mainTable">
            <!-- Table data will be loaded by js. -->
            </tbody>
        </table>
    </div>
</div>

<div class="modal fade" id="addCategoryDialog" tabindex="-1" role="dialog" aria-labelledby="addCategoryDialogLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addCategoryDialogLabel">添加分类</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="col-md-12">
                            <input type="text" class="form-control" id="addCategoryName" placeholder="分类名称">
                        </div>
                    </div>
                </form>
                <p id="addCategoryStatus"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnAddCategory">添加</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="updateCategoryDialog" tabindex="-1" role="dialog" aria-labelledby="updateCategoryDialogLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateCategoryDialogLabel">修改分类名称</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <input type="text" class="form-control hidden" id="updateCategoryId">
                    <div class="form-group">
                        <div class="col-md-12">
                            <input type="text" class="form-control" id="updateCategoryName" placeholder="分类名称">
                        </div>
                    </div>
                </form>
                <p id="updateCategoryStatus"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" id="btnUpdateCategory">修改</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="deleteCategoryDialog" tabindex="-1" role="dialog" aria-labelledby="deleteCategoryDialogLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="deleteCategoryDialogLabel">删除分类</h4>
            </div>
            <div class="modal-body">
                <p id="deleteCategoryText"></p>
                <input type="text" class="form-control hidden" id="deleteCategoryId">
                <p id="deleteCategoryStatus"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="btnDeleteCategory">删除</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="categoryDetailDialog" tabindex="-1" role="dialog" aria-labelledby="categoryDetailDialogLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="categoryDetailDialogLabel">分类详情</h4>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>书籍编号</th>
                                <th>书籍名称</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="detailTable">
                        <!-- Table data will be loaded by js. -->
                        </tbody>
                    </table>
                </div>
                <p id="categoryDetailStatus"></p>  
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="addBookToCategoryDialog" tabindex="-1" role="dialog" aria-labelledby="addBookToCategoryDialogLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addBookToCategoryDialogLabel">添加书籍到分类</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <input type="text" class="form-control hidden" id="addBookToCategoryCategoryId">
                    <div class="form-group">
                        <div class="col-md-12">
                            <input type="number" class="form-control" id="addBookToCategoryBookId" min="1" placeholder="输入要添加到此分类的书籍编号">
                        </div>
                    </div>
                </form>
                <p id="addBookToCategoryStatus"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnAddBookToCategory">添加</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../profile.jsp" />

<jsp:include page="../layout/content_footer.jsp" />

<jsp:include page="../layout/common_js.jsp" />

<script src="<s:url value="/js/admin/category.js"/>"></script>
<script src="<s:url value="/js/profile.js"/>"></script>

<jsp:include page="../layout/page_end.jsp" />

