//= require jquery.dataTables
//= require jquery.datatables.fnSetFilteringDelay
//= require jquery.datatables.fnReloadAjax

root = exports ? this
  
root.simpleDatatables = ( sSource, aoData, fnCallback ) ->
      
  columns = [];
  searchcolumns = [];
  sortcolumns = [];
  
  sEcho = 1;
  sSearch = "";
  bRegex = false;
  iDisplayStart = 0;
  iDisplayLength = 0;
  data = [];

  $.each(aoData, (index, dataObj) -> 
    switch dataObj.name
      when "sColumns"
        columns = dataObj.value.split(",");
      when "sEcho"
        sEcho = dataObj.value;
      when "sSearch"
        sSearch = dataObj.value;
      when "bRegex"
        bRegex = dataObj.value;
      when "iDisplayStart"
        iDisplayStart = dataObj.value;
      when "iDisplayLength"
        iDisplayLength = dataObj.value;
      when "iSortCol_0"
        console.log("yobanarot!");
        iSortCol = dataObj.value;
      when "sSortDir_0"
        sSortDir = dataObj.value;
      else
        console.log(dataObj.name);
  );

  $.each(aoData, (index, dataObj) -> 
    search_regexp = ///sSearch_([0-9]+)///
    if (col = dataObj.name.match(search_regexp)) and dataObj.value
      data.push({name: "search["+columns[col[1]]+"_sw"+"]", value: dataObj.value});

    search_regexp = ///bSearchable_([0-9]+)///
    if (col = dataObj.name.match(search_regexp)) and dataObj.value
      searchcolumns.push(columns[col[1]]);

    search_regexp = ///iSortCol_([0-9]+)///
    if (col = dataObj.name.match(search_regexp))
      sortcolumns[parseInt(col[1])]=columns[parseInt(dataObj.value)];

    search_regexp = ///sSortDir_([0-9]+)///
    if (col = dataObj.name.match(search_regexp)) and dataObj.value
      sortcolumns[col[1]]=sortcolumns[col[1]]+"."+dataObj.value;

  );

  data.push({name: "sEcho", value: sEcho});
  data.push({name: "page", value: iDisplayStart/iDisplayLength + 1});
  data.push({name: "per_page", value: iDisplayLength});
  data.push({name: "search[meta_sort]", value: sortcolumns[0]});

  $.each(columns, (index, val) -> 
    data.push({name: "columns["+index+"]", value: val});
  );

  if sSearch
    op =
      if bRegex
        "_contains"
      else
        "_sw"
    data.push({name: "search["+searchcolumns.join("_or_")+op+"]", value: sSearch});

  $.ajax( { "dataType": 'json', "type": "GET", "url": sSource, "data": data, "success": fnCallback } );
  