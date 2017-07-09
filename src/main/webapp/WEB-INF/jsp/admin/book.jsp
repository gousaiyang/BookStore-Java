<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<jsp:include page="../layout/page_head.jsp" />

<jsp:include page="../layout/content_navbar_admin.jsp" />

<div class="container">
    <h1>书籍管理
        <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#addDialog">
            <span class="glyphicon glyphicon-plus"></span>
        </button>
    </h1>
    <div class="alert alert-info fade in" role="alert"><span class="glyphicon glyphicon-time"></span> 正在加载书籍信息...</div>
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>编号</th>
                    <th>书名</th>
                    <th>单价</th>
                    <th>库存量</th>
                    <th>创建时间</th>
                    <th>修改时间</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
            <!-- Table data will be loaded by js. -->
            </tbody>
        </table>
    </div>
</div>

<div class="modal fade" id="addDialog" tabindex="-1" role="dialog" aria-labelledby="addDialogLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addDialogLabel">添加书籍</h4>
            </div>
            <div class="modal-body">
                <div class="media">
                    <div class="media-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label for="addBookName" class="col-sm-2 control-label">书名</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="addBookName" placeholder="书籍名称">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="addBookAuthor" class="col-sm-2 control-label">作者</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="addBookAuthor" placeholder="书籍作者">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="addBookPress" class="col-sm-2 control-label">出版社</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="addBookPress" placeholder="书籍出版社">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="addBookPrice" class="col-sm-2 control-label">单价</label>
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <span class="input-group-addon">&#65509;</span>
                                        <input type="text" class="form-control" id="addBookPrice" placeholder="书籍单价">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="addBookStock" class="col-sm-2 control-label">库存</label>
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="addBookStock" placeholder="库存量">
                                        <span class="input-group-addon">本</span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">分类</label>
                                <div class="col-sm-10">
                                    <p class="form-control-static"><span class="glyphicon glyphicon-info-sign"></span> 请至“分类管理”面板为此书籍添加分类信息。</p>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="media-right">
                        <img class="media-object book-image" id="addBookImageShow">
                        <p class="tip-under-image" id="addBookUploadTips"></p>
                        <button type="button" class="btn btn-block btn-primary" id="addBookUploadBtn">上传书籍图片</button>
                        <input type="text" class="form-control hidden" id="addBookImage">
                    </div>
                </div>
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="col-sm-12">
                            <textarea class="form-control" rows="5" id="addBookDescription" placeholder="写一些关于书籍的简要介绍"></textarea>
                        </div>
                    </div>
                </form>
                <p id="addBookStatus"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnAddBook">添加</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="updateDialog" tabindex="-1" role="dialog" aria-labelledby="updateDialogLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateDialogLabel">书籍详情</h4>
            </div>
            <div class="modal-body">
                <div class="media">
                    <div class="media-body">
                        <form class="form-horizontal">
                            <input type="text" class="form-control hidden" id="updateBookId">
                            <div class="form-group">
                                <label for="updateBookName" class="col-sm-2 control-label">书名</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="updateBookName" placeholder="书籍名称">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="updateBookAuthor" class="col-sm-2 control-label">作者</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="updateBookAuthor" placeholder="书籍作者">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="updateBookPress" class="col-sm-2 control-label">出版社</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="updateBookPress" placeholder="书籍出版社">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="updateBookPrice" class="col-sm-2 control-label">单价</label>
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <span class="input-group-addon">&#65509;</span>
                                        <input type="text" class="form-control" id="updateBookPrice" placeholder="书籍单价">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="updateBookStock" class="col-sm-2 control-label">库存</label>
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="updateBookStock" placeholder="库存量">
                                        <span class="input-group-addon">本</span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">分类</label>
                                <div class="col-sm-10">
                                    <p class="form-control-static" id="bookCategories"></p>
                                </div>
                            </div>
                            <p><span class="glyphicon glyphicon-info-sign"></span> 请至“分类管理”面板管理此书籍的分类信息。</p>
                        </form>
                    </div>
                    <div class="media-right">
                        <img class="media-object book-image" id="updateBookImageShow">
                        <p class="tip-under-image" id="updateBookUploadTips"></p>
                        <button type="button" class="btn btn-primary btn-block" id="updateBookUploadBtn">更换书籍图片</button>
                        <button type="button" class="btn btn-danger btn-block" id="deleteBookImageBtn">删除书籍图片</button>
                        <input type="text" class="form-control hidden" id="updateBookImage">
                    </div>
                </div>
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="col-sm-12">
                            <textarea class="form-control" rows="5" id="updateBookDescription" placeholder="写一些关于书籍的简要介绍"></textarea>
                        </div>
                    </div>
                </form>
                <div class="row" id="timeDetailText"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" id="btnUpdateBook">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="deleteDialog" tabindex="-1" role="dialog" aria-labelledby="deleteDialogLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="deleteDialogLabel">删除书籍</h4>
            </div>
            <div class="modal-body">
                <p id="deleteText"></p>
                <input type="text" class="form-control hidden" id="deleteBookId">
                <p id="deleteBookStatus"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="btnDeleteBook">删除</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/content_footer.jsp" />

<jsp:include page="../layout/common_js.jsp" />

<script src="<s:url value="/js/admin/book.js"/>"></script>

<jsp:include page="../layout/page_end.jsp" />

