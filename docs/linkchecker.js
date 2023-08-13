function uriOk(num)
{
    if (!document.getElementById) {
        return true;
    }

    var u = document.getElementById('uri_' + num);
    var ok = false;
    if (u.value.length > 0) {
        if (u.value.search) {
            ok = (u.value.search(/\S/) !== -1);
        }
        else {
            ok = true;
        }
    }
    if (!ok) {
        u.focus();
    }
    return ok;
}

function show_progress(progress_id, progress_text, progress_percentage)
{
    var div = document.getElementById("progress" + progress_id);

    var head = div.getElementsByTagName("h3")[0];
    var text = document.createTextNode(progress_text);
    var span = document.createElement("span");
    span.appendChild(text);
    head.replaceChild(span, head.getElementsByTagName("span")[0]);

    var label = div.getElementsByTagName("label")[0];
    var labelText = label.getElementsByTagName("span")[0];
    labelText.textContent = "Progress: " + progress_percentage;

    var bar = label.getElementsByTagName("progress")[0];
    bar.value = Number.parseFloat(progress_percentage);
    bar.textContent = progress_percentage;

    var pre = div.getElementsByTagName("pre")[0];
    pre.scrollTop = pre.scrollHeight;
}
