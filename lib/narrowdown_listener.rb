class NarrowdownListener < Redmine::Hook::ViewListener
  def view_issues_edit_notes_bottom(*args)
js=<<'JS'
(function(){
  var e = $("issue_assigned_to_id");
  if(e){
    var useridlist={};
    $$("a[href*=users]").each(function(a){
      if(/users\/([\d]+)/.test(a.href)){
        useridlist[RegExp.$1]=true;
      }
    });
    var is = document.createElement("input");
    is.setAttribute("type","checkbox");
    e.parentNode.insertBefore(is,e.nextSibling);
    var label = document.createElement("span");
    label.appendChild(document.createTextNode("関係者のみ"));
    label.setAttribute("style","font-size:80%;cursor:pointer");
    is.id = label.for;
    e.parentNode.insertBefore(label,is.nextSibling);
    $(label).observe("click",function(){
      is.click();
    });
    $(is).observe("change",function(){
      for(var i=0;i<e.options.length;i++){
        var o = e.options[i];

        if(is.checked && !useridlist[o.value]){
          o.style.display="none";
        }else{
          o.style.display="";
        }
      }
    });
  }
})();
JS

  "<script>//<![CDATA[\n#{js}\n//]]></script>"
  end
end
