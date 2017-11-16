

//--- jqGrid
//= require jqgrid/js/jquery.jqGrid.min.js
//= require jqgrid/js/i18n/grid.locale-en.js

//--- Datatables
//= require datatables/media/js/jquery.dataTables.min
//= require datatables-colvis/js/dataTables.colVis
//= require datatables/media/js/dataTables.bootstrap
//= require datatables/media/js/dataTables.editor.min
//= require datatables/media/js/dataTables.select.min

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



    // initComplete();
    //
    // Zero configuration
    //
    // var gridJSON = $("#jqGridItemList");
    loaddatatable(vendor_id);
    // gridJSON.jqGrid({
    //     url: '/api/venderitemlist?vendor_id='+vendor_id,
    //     datatype: "json",
    //       colNames: ['Id','ASIN','Name','Vendor','BBP', 'UPC','COST', 'FBA fee','Margin','Profit', 'ComPCT','ComFee','EST','Offer', 'FBA', 'FBM'],
    //       colModel: [
    //         { label: 'id', name: 'id', width: 75 },
    //         { index: 'asin', name: 'asin', width: 120 },
    //         { index: 'name', name: 'name', width: 400 },
    //         { index: 'vendor', name: 'vendor', width: 120 },
    //         { index: 'buyboxprice', name: 'buyboxprice', width: 100 },
    //         { index: 'upc', name: 'upc', width: 80},
    //         { index: 'cost', name: 'cost', width: 80},
    //         { index: 'fbafee', name: 'fbafee', width: 80},
    //         { index: 'margin', name: 'margin', width: 80},
    //         { index: 'profit', name: 'profit', width: 80},
    //         { index: 'commissionpct', name: 'commissionpct', width: 80},
    //         { index: 'commissiionfee', name: 'commissiionfee', width: 80},
    //         { index: 'salespermonth', name: 'salespermonth', width: 80},
    //         { index: 'totaloffers', name: 'totaloffers', width: 80},
    //         { index: 'fbaoffers', name: 'fbaoffers', width: 80},
    //         { index: 'fbmoffers', name: 'fbmoffers', width: 80},
    //       ],
    //     viewrecords: true, // show the current page, data rang and total records on the toolbar
    //     // autowidth: true,
    //     // shrinkToFit: true,
    //     height: 'auto',
    //     sortname: 'id',
    //     rowNum: 10,
    //     toppager:true,
    //     rowList: [10, 20, 30],
    //     caption: "Skynet History",
    //     pager: "#jqGridItemListPager",
    //     loadComplete: loadComplete
    //   });


    // $(window).on('resize', function() {
    //     var width = $('.jqgrid-responsive').width();
    //     // gridJSON.setGridWidth( width );
    //     // gridTree.setGridWidth( width );
    // }).resize();

    // gridJSON.jqGrid('navGrid','#jqGridItemList_toppager',{edit:false,add:false,del:false,cloneToTop:true});

    // gridJSON.jqGrid('filterToolbar', { stringResult: true, searchOnEnter: false, defaultSearch: "cn" });
    
  });

})(window, document, window.jQuery);

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

