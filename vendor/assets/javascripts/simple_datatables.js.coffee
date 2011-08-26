//= require jquery.dataTables.min

root = exports ? this
  
root.simpleDatatables = ( sSource, aoData, fnCallback ) ->
      
  columns = [];
  searchcolumns = [];
  
  sEcho = 1;
  sSearch = "";
  iDisplayStart = 0;
  iDisplayLength = 0;
  iSortCol = 0;
  sSortDir = "asc";
  data = [];
  
  console.log(aoData);
      
  $.each(aoData, (index, dataObj) -> 
    switch dataObj.name
      when "sColumns"
        columns = dataObj.value.split(",");
      when "sEcho"
        sEcho = dataObj.value;
      when "sSearch"
        sSearch = dataObj.value;
      when "iDisplayStart"
        iDisplayStart = dataObj.value;
      when "iDisplayLength"
        iDisplayLength = dataObj.value;
      when "iSortCol_0"
        iSortCol = dataObj.value;
      when "sSortDir_0"
        sSortDir = dataObj.value;
  );
      
  $.each(aoData, (index, dataObj) -> 
    search_regexp = ///sSearch_([0-9]+)///
    if (col = dataObj.name.match(search_regexp)) and dataObj.value
      data.push({name: "search["+columns[col[1]]+"_contains]", value: dataObj.value});

    search_regexp = ///bSearchable_([0-9]+)///
    if (col = dataObj.name.match(search_regexp)) and dataObj.value
      searchcolumns.push(columns[col[1]]);
  );

  data.push({name: "sEcho", value: sEcho});
  data.push({name: "page", value: iDisplayStart/iDisplayLength + 1});
  data.push({name: "per_page", value: iDisplayLength});
  data.push({name: "search[meta_sort]", value: columns[iSortCol]+"."+sSortDir});

  $.each(columns, (index, val) -> 
    data.push({name: "columns["+index+"]", value: val});
  );
  
  if sSearch
    data.push({name: "search["+searchcolumns.join("_or_")+"_contains]", value: sSearch});

  $.ajax( { "dataType": 'json', "type": "GET", "url": sSource, "data": data, "success": fnCallback } );
  