/* your js go here */
$(function () {


    $("#avatar").click(function () {
        console.log("你点击了头像");
        window.location.href = '../html/user_look.html'
    });

    //file表单选中文件时,让file表单的val展示到showname这个展示框
    $('#myFile').change(function () {
        $('#showname').val($(this).val())
    });

    //用户列表，查看详情，通过class名字userDetail来找
    $(".userDetail").click(function () {
        console.log("你点击了用户详情");
        window.location.href = '../html/user_detail.html'
    });

    //发布会议跳转链接
    $("#addMeet").click(function () {
        window.location.href = '../html/meeting_add.html'
    });

    //添加文章跳转链接
    $("#addArt").click(function () {
        window.location.href = '../html/article_add.html'
    });


    $(".myList>ul>li").on("click",function () {
        if($(this).find("div").attr('class')=='list-group myGroup isHidden'){
            $(this).find("div").removeClass("isHidden")
        }else{
            $(this).find("div").addClass("isHidden")
        }


    })

    $(".table").find("input[type='checkbox']").on("click",function () {
        if($(this).prop("checked")){
            layer.msg("关注成功")
        }else{
            layer.msg("取关成功")

        }

    })

    /*$('.chosen').chosen({
        no_results_text: "没有找到结果！",//搜索无结果时显示的提示
        search_contains:true,   //关键字模糊搜索。设置为true，只要选项包含搜索词就会显示；设置为false，则要求从选项开头开始匹配
        allow_single_deselect:true, //单选下拉框是否允许取消选择。如果允许，选中选项会有一个x号可以删除选项
        disable_search: false, //禁用搜索。设置为true，则无法搜索选项。
        disable_search_threshold: 0, //当选项少等于于指定个数时禁用搜索。
        inherit_select_classes: true, //是否继承原下拉框的样式类，此处设为继承
        placeholder_text_single: '选择国家', //单选选择框的默认提示信息，当选项为空时会显示。如果原下拉框设置了data-placeholder，会覆盖这里的值。
        width: '400px', //设置chosen下拉框的宽度。即使原下拉框本身设置了宽度，也会被width覆盖。
        max_shown_results: 1000, //下拉框最大显示选项数量
        display_disabled_options: false,
        single_backstroke_delete: false, //false表示按两次删除键才能删除选项，true表示按一次删除键即可删除
        case_sensitive_search: false, //搜索大小写敏感。此处设为不敏感
        group_search: false, //选项组是否可搜。此处搜索不可搜
        include_group_label_in_selected: true //选中选项是否显示选项分组。false不显示，true显示。默认false。
    });*/
});

//触发隐藏的file表单
function makeThisfile() {
    $('#myFile').click();
}