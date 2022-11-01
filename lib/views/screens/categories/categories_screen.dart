import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Assistants/globals.dart';
import '../../../Data/data_for_ui.dart';
import '../../../controllers/catgories_controller.dart';
import '../../../controllers/lang_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../widgets/departments_list_r.dart';
import '../home/search_area_des.dart';
import '../show_product/products_of_department_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List categoriesButtons = [];
  List<Widget> brandsWidgets = [];
  List colors =[];
  Color color =Colors.grey;
  List<double> opacityColor = [];
  bool showBrands =true;
  final CategoriesController categoriesController = Get.find();
  final LangController langController = Get.find();
  final ProductsController productController = Get.find();

  var departmentContent =[];
  var brandsContent =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    departmentContent = womenFashionDepartments;
    brandsContent =womenFashionDepartments;
    //createBrandsList();
  }
  Widget buildCategoriesButtons(var data,int index){
    for(int i =0; i<categoriesController.mainCategories.length;i++){
      if(i==0){
        colors.add(myHexColor);
        opacityColor.add(1.0);

      }else{
        opacityColor.add(0.7);
        colors.add(Colors.black);
      }}
      return InkWell(
        onTap: (){
          print('object');
          departmentContent = categoriesController.departmentsListOfCategories[index];
          // switch (index){
          //   case 0:
          //     showBrands= true;
          //     departmentContent = womenFashionDepartments;
          //     brandsContent = womenFashionDepartments;
          //     if(womenFashionDepartments[0]['hasChildren']==true ){
          //       productController
          //           .getProductsByCat(womenFashionDepartments[0]['depId'],langController.appLocal);
          //     }
          //     break;
          //   case 1:
          //     showBrands= true;
          //
          //     departmentContent = menFashionDepartments;
          //     break;
          //   case 2:
          //     showBrands= true;
          //
          //     departmentContent = childrenAndToysDepartments;
          //     break;
          //   case 3:
          //     showBrands= true;
          //
          //     departmentContent = accessoriesAndGifts;
          //     break;
          //   case 4:
          //     showBrands= true;
          //
          //     departmentContent = beautySuppliesAndPersonalCare;
          //     break;
          //   case 5:
          //     showBrands= true;
          //
          //     departmentContent = mensStuff;
          //     break;
          //   case 6:
          //     showBrands= true;
          //
          //     departmentContent = mobilesAndAccessories;
          //     break;
          //   case 7:
          //     showBrands= true;
          //
          //     departmentContent = homeKitchen;
          //     break;
          //   case 8:
          //     setState(() {
          //       showBrands =false;
          //     });
          //     departmentContent = brands;
          //     break;
          //   case 9:
          //     showBrands= true;
          //
          //     departmentContent = watchesAndBags;
          //     break;
          //   case 10:
          //     showBrands= true;
          //
          //     departmentContent = mensShoes;
          //     break;
          //   case 11:
          //     showBrands= true;
          //
          //     departmentContent = womenShoes;
          //     break;
          //   case 12:
          //     showBrands= true;
          //
          //     departmentContent = kidsShoes;
          //     break;
          //   case 13:
          //     showBrands= true;
          //
          //     departmentContent = childrenClothes;
          //     break;
          // }
          setState(() {

            for(int i =0; i<colors.length;i++){
             if(index==i){
               colors[index]= myHexColor;
               opacityColor[index]= 1.0;
             }else{
               opacityColor[i]= 0.7;
               colors[i]=Colors.black;
             }
           }
          });

        },
        child: Container(

          height: 76.h,
          width: 79.w,
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage("$baseURL/${data['image']}",),fit: BoxFit.fill)
          ),
          child: Container(
              color: colors[index].withOpacity(opacityColor[index]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(langController.appLocal=='en'?data['name_EN'].toString():data['name_AR'].toString(),maxLines: 2,textAlign: TextAlign.center,style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w600,color: Colors.white),)),
              )),
        ),
      );

  }
   createBrandsList(){
     final screenSize= MediaQuery.of(context).size;

     for(int i =0; i<categories.length;i++){
      brandsWidgets.add(Padding(
          padding: EdgeInsets.zero,
          child: Column(
            children: <Widget>[
              i==1 ? Container(width:screenSize.width ,height: 7,color: Colors.red[500],):Container(),
              Container(
                height: 59.h,
                width: 59.w,
                //padding:  EdgeInsets.all(0.1),
                decoration:  BoxDecoration(
                  color: myHexColor,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  child: Image.asset(
                    categories[i]['imagePath'].toString(),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Text(categories[i]['catName'].toString(),style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
            ],
          )));
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Key? key;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: myHexColor5,
      child: SafeArea(child: Scaffold(
        body: Column(
          children:  [
             SizedBox(
              height: 6.0.h,
            ),
            const SearchAreaDesign(),
             SizedBox(
              height: 12.0.h,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: screenSize.width *0.2.w,
                    height:screenSize.height <700? screenSize.height*.9-93.h:screenSize.height*.9-83.h,
                    child: CustomScrollView(
                      slivers: [
                        SliverList(delegate: SliverChildBuilderDelegate(
                            (context,index)=> buildCategoriesButtons(categoriesController.mainCategories[index], index),childCount: categoriesController.mainCategories.length
                        ))
                      ],
                    )

                  ),
                  Expanded(
                    child: SizedBox(
                      height:screenSize.height <700? screenSize.height*.9-93.h:screenSize.height*.9-83.h,
                      width: screenSize.width -101.w,
                      child:  Padding(
                        padding:  EdgeInsets.only(bottom:2.h),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Positioned(
                                top: 0.0,
                                child: Container(width:screenSize.width.w ,height: 0.5.h,color: Colors.grey[500],)),

                            CustomScrollView(
                              anchor: 0.0,

                              slivers:<Widget> [
                                _buildTitle('Category_txt'.tr,screenSize,),
                               _buildListOfDepartments(departmentContent,true,0),

                                // _buildTitle(showBrands?'Brands_txt'.tr:''),
                                // _buildListOfDepartments(showBrands?brandsContent:[]),

                                // _buildTitle(langController.appLocal=="ar"?departmentContent[0]['depNameAR']:departmentContent[0]['depName'],screenSize,),
                                // _buildListOfDepartments(departmentContent,false,0),
                                //
                                // _buildTitle(langController.appLocal=="ar"?departmentContent[1]['depNameAR']:departmentContent[0]['depName'],screenSize,),
                                // _buildListOfDepartments(departmentContent,false,1),

                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),

      ),),
    );
  }
  Widget _buildTitle(String title,screenSize){
    return  SliverAppBar(
        floating: false,
        expandedHeight: 1,
        titleSpacing: 6.0,
        centerTitle: false,
        foregroundColor: Colors.transparent.withOpacity(0.0),
    backgroundColor: Colors.white.withOpacity(0.0),
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
            width: screenSize.width *0.3.w,
            child: Text(title,textAlign: TextAlign.start,overflow:TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18.sp,color: Colors.black))),
        Spacer(),
        SizedBox(width: screenSize.width*.1.w,),
        Spacer(),
        Icon(Icons.keyboard_arrow_down_rounded,size: 22.sp,color: Colors.grey[800],)
      ],
    ));
    // flexibleSpace: FlexibleSpaceBar(
    //   title: Text('AAAAAAAA',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black),),
    // ),
  }
  Widget _buildListOfDepartments(categories,bool hasChildren,int i){
    var screenSize= MediaQuery.of(context).size;
    return  SliverGrid(
      delegate: SliverChildBuilderDelegate(
              (context,index){
            return InkWell(
              onTap: ()async{
                 //categoriesController.getListCategoryByCategory(categoriesController.mainCategories[index]['id']);
                 //print(categories[index]['hasChildren']);
                Get.to(()=> ProductsOfDepartmentScreen(depId: categories[index]['id'],haveChildren: categories[index]['children']));
              },
              child: Padding(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: screenSize.height *0.1+8.h,
                        width: screenSize.width *0.2.w,
                        //padding:  EdgeInsets.all(0.1),
                        decoration:  BoxDecoration(
                          color: myHexColor,
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                          child: Image.network(
                            "$baseURL/${categories[index]['image']}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(langController.appLocal=="ar"?categories[index]['name_AR'].toString():categories[index]['name_EN'].toString(),style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                    ],
                  )),
            );

          },childCount:categories.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 1.0.w,
          crossAxisSpacing: 1.0.h,
          childAspectRatio: 0.7.h,
          crossAxisCount: 3),);

  }
}
