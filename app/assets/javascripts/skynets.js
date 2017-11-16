

//--- jqGrid
//= require jqgrid/js/jquery.jqGrid.min.js
//= require jqgrid/js/i18n/grid.locale-en.js

//--- Datatables
//= require datatables/media/js/jquery.dataTables.min
//= require datatables-colvis/js/dataTables.colVis
//= require datatables/media/js/dataTables.bootstrap

//--- Datatables Buttons
//= require datatables-buttons/js/dataTables.buttons
//= datatables-buttons/css/buttons.bootstrap.css
//= require datatables-buttons/js/buttons.bootstrap
//= require datatables-buttons/js/buttons.colVis
//= require datatables-buttons/js/buttons.flash
//= require datatables-buttons/js/buttons.html5
//= require datatables-buttons/js/buttons.print
//= require datatables-responsive/js/dataTables.responsive
//= require datatables-responsive/js/responsive.bootstrap
var editor; // use a global for the submit and return data rendering in the examples

(function(window, document, $, undefined){

  $(function(){
    
    if ( ! $.fn.jqGrid ) return;
    // JSON EXAMPLE
    // ---------------------
    // var gridJSON = $("#jqGridSkynetList");

    
    // gridJSON.jqGrid({
    //     url: '/api/skynetgridhistory',
    //     datatype: "json",
    //       colNames: ['Input','Vendor','Uploaded On','Output'],
    //       colModel: [
    //         // { label: 'Input', name: 'id', width: 75 },
    //         { index: 'inputfilename', name: 'inputfilename', width: 75 },
    //         { index: 'vendor', name: 'vendor', width: 90 },
    //         { index: 'created_at', name: 'created_at', width: 100, search: false },
    //         { index: 'outputurl', name: 'outputurl', width: 80, search: false, formatter:outputdownload},
    //       ],
    //     viewrecords: true, // show the current page, data rang and total records on the toolbar
    //     // autowidth: true,
    //     // shrinkToFit: true,
    //     height: 'auto',
    //     rowNum: 10,
    //     sortname: 'id',
    //     // multiselect: true,
    //     rowList: [10, 20, 30],
    //     caption: "Skynet History",
    //     pager: "#jqGridSkynetListPager",
    //     toppager:true,
    //     loadComplete: loadComplete
    //   });


    // $(window).on('resize', function() {
    //     var width = $('.jqgrid-responsive').width();
    //     gridJSON.setGridWidth( width );
    //     // gridTree.setGridWidth( width );
    // }).resize();

    // gridJSON.jqGrid('navGrid','#jqGridSkynetList_toppager',{edit:false,add:false,del:false,cloneToTop:true});

    // gridJSON.jqGrid('filterToolbar', { stringResult: true, searchOnEnter: false, defaultSearch: "cn" });

    
    $('#datatable_skynethistory').dataTable({
        'paging':   true,  // Table pagination
        'ordering': true,  // Column ordering
        'info':     true,  // Bottom left status text
        'responsive': true, // https://datatables.net/extensions/responsive/examples/
        // "bPaginate": true,
        "iDisplayLength" : 10,
        "processing": true,
        "serverSide": true,
        sAjaxSource: '/api/skynethisotry',
        aoColumns: [
          { mData: 'inputfilename',
            "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
              $(nTd).html("<a href='"+oData.inputfileurl+"'>"+oData.inputfilename+"</a>");
            }
          },
          { mData: 'name' },
          { mData: 'outputfileurl' },
          { mData: 'created_at' },
        ],
        "columnDefs": [ {
            "targets": 2,//index of column starting from 0
            "data": "outputurl", //this name should exist in your JSON response
            "render": function ( data, type, full, meta ) {
                if(data != '' && data != null){
                    return "<a href=\""+data+"\">Download</a>";
                }else{
                    return 'Not Completed';
                }
              return '<span class="label label-danger">'+data+'</span>';
            }
          },
          // {
          //     "targets": 0,//index of column starting from 0
          //     "data": "inputfileurl", //this name should exist in your JSON response
          //     "render": function ( data, type, full, meta ) {
          //         return "<a href=\""+data+"\">Download</a>";
                 
          //     }
          // }
         ],
        "order": [[ 3, "desc" ]],
        // sDom:      'C<"clear">lfrtip',
        // colVis: {
        //     order: 'alfa',
        //     'buttonText': 'Show/Hide Columns'
        // }
    });

  });

  // loaddatatable(vendor_id);
    
    

})(window, document, window.jQuery);


function loadComplete(){
    var grid = $("#jqGridSkynetList");
    var ids = grid.getDataIDs();
    for (var i=0; i<ids.legthn;i++){

    }
}

function outputdownload (cellvalue, options, rowObject) {
    if(cellvalue == null)
        return "In Progress";
    return "<a href='"+cellvalue+"'><em class='fa fa-download'>"+"Download"+"</em></a>";
}

document.getElementById("file_field").onchange = function(){
    document.getElementById("filefeed").submit();
}

$("#vendor_id").change(function(){

  // var vendor = $(this).val();
  // $("#jqGridItemList").trigger("reloadGrid");
  loaddatatable(vendor);
    
});

function loaddatatable(vendor_id){

  if ( $.fn.dataTable.isDataTable( '#datatable_itemlist' ) ) {
      table = $('#datatable_itemlist').DataTable();
      table.destory();
  }

  initComplete();
  

  var table = $('#datatable_itemlist').DataTable({
        dom: "Bfrtip",
        destroy: true,
        'paging':   true,  // Table pagination
        'ordering': true,  // Column ordering
        'info':     true,  // Bottom left status text
        // 'responsive': true, // https://datatables.net/extensions/responsive/examples/
        // "bPaginate": true,
        "iDisplayLength" : 10,
        "processing": true,
        "serverSide": true,
        "scrollX": true,
        sAjaxSource: '/api/getitemlist?vendor='+vendor_id,
        aoColumns: [
          // {
          //       mdata: null,
          //       defaultContent: '',
          //       className: 'select-checkbox',
          //       orderable: false
          //   },
          { mData: 'id' },
          { mData: 'name' },
          { mData: 'asin' },
          { mData: 'vendorsku' },
          { mData: 'upc' },
          { mData: 'cost' ,render: $.fn.dataTable.render.number( ',', '.', 2, '$' )},
          { mData: 'packcount' },
          { mData: 'packcost', render: $.fn.dataTable.render.number( ',', '.', 2, '$' ) },
          { mData: 'buyboxprice' },
          { mData: 'profit'},
          { mData: 'margin'},
          { mData: 'fbafee' },
          { mData: 'commissionpct' },
          { mData: 'commissiionfee' },
          { mData: 'salespermonth' },
          { mData: 'totaloffers' },
          { mData: 'fbaoffers' },
          { mData: 'fbmoffers' },
        ],
        columnDefs: [
          { orderable: false, targets: [0] }
        ],
        "order": [[ 1, "asc" ]],
        "createdRow": function(row, data, dataIndex){
          //$('td:eq(1)', row).css('min-width', '200px');
        },
        sDom:      'C<"clear">lfrtip',
        colVis: {
            order: 'alfa',
            'buttonText': 'Show/Hide Columns'
        },
        select: {
            style:    'os',
            selector: 'td:first-child'
        },
        buttons: [
            { extend: "create", editor: editor },
            { extend: "edit",   editor: editor },
            { extend: "remove", editor: editor }
        ]
    });

    // Apply the search
    // table.columns().every( function () {
    //     var that = this;
    //     $( 'input', this.header() ).on( 'keyup change', function () {
    //         console.log('asd');
    //         if ( that.search() !== this.value ) {
    //             that
    //                 .search( this.value )
    //                 .draw();
    //         }
    //     } );
    // } );
    $("#datatable_itemlist_wrapper thead input").on('keyup change', function() {
        table
            .column($(this).parent().index() + ':visible')
            .search(this.value)
            .draw();
    });

     $('#datatable_itemlist').on( 'click', 'tbody td:not(:first-child)', function (e) {
      editor.inline( this );
      // editor.bubble( this );
  } );


}

function initComplete () {
  // var r = $('#datatable_itemlist tfoot tr');
  // r.find('th').each(function(){
  //   $(this).css('padding', 10);
  // });
  // $('#datatable_itemlist thead').append(r);
  // $('#search_0').css('text-align', 'center');

  $('#datatable_itemlist #table_search_row th:not(:first-child)').each( function () {
      var title = $(this).text();
      if(title != 'Margin' && title != 'Profit' || 1){
        $(this).html( '<input type="text" placeholder="'+title+'" />' );  
      }else{
        $(this).html( '');  
      }
      
  } );
  
  editor = new $.fn.DataTable.Editor( {
      ajax: "api/updatevendoritem",
      table: "#datatable_itemlist",
      idSrc:  'id',
      fields: [ {
              label: "Packcount",
              name: "packcount"
          }, {
              label: "COST",
              name: "cost"
          }
      ]
  } );

  // Activate an inline edit on click of a table cell
 
}