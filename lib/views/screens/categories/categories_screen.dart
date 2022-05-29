import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Assistants/globals.dart';
import '../../../Data/data_for_ui.dart';
import '../../../controllers/catgories_controller.dart';
import '../../widgets/departments_list_r.dart';
import '../home/search_area_des.dart';
import '../show_product/products_of_department_screen.dart';

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

  var departmentContent =[];
  var brandsContent =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    departmentContent = womenFashionDepartments;
    brandsContent =womenFashionDepartments;
    createBrandsList();
  }
  Widget buildCategoriesButtons(var data,int index){
    for(int i =0; i<categories.length;i++){
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
          switch (index){
            case 0:
              showBrands= true;
              departmentContent = womenFashionDepartments;
              brandsContent = womenFashionDepartments;
              break;
            case 1:
              showBrands= true;

              departmentContent = menFashionDepartments;
              break;
            case 2:
              showBrands= true;

              departmentContent = kidsBabyToysDepartments;
              break;
            case 3:
              showBrands= true;

              departmentContent = accessoriesAndGifts;
              break;
            case 4:
              showBrands= true;

              departmentContent = beautySuppliesAndPersonalCare;
              break;
            case 5:
              showBrands= true;

              departmentContent = mensStuff;
              break;
            case 6:
              showBrands= true;

              departmentContent = mobilesAndAccessories;
              break;
            case 7:
              showBrands= true;

              departmentContent = homeKitchen;
              break;
            case 8:
              setState(() {
                showBrands =false;
              });
              departmentContent = brands;
              break;
            case 9:
              showBrands= true;

              departmentContent = watchesAndBags;
              break;
            case 10:
              showBrands= true;

              departmentContent = mensShoes;
              break;
            case 11:
              showBrands= true;

              departmentContent = womenShoes;
              break;
            case 12:
              showBrands= true;

              departmentContent = kidsShoes;
              break;
          }
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

          height: 76,
          width: 79,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(data['imagePath'].toString(),),fit: BoxFit.fill)
          ),
          child: Container(
              color: colors[index].withOpacity(opacityColor[index]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(data['catName'].toString(),maxLines: 2,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),)),
              )),
        ),
      );

  }
  final screenSize = Get.size;

   createBrandsList(){
    for(int i =0; i<categories.length;i++){
      brandsWidgets.add(Padding(
          padding: EdgeInsets.zero,
          child: Column(
            children: <Widget>[
              i==1 ? Container(width:screenSize.width ,height: 7,color: Colors.red[500],):Container(),
              Container(
                height: 59,
                width: 59,
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
              SizedBox(height: 5),
              Text(categories[i]['catName'].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
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

    return Container(
      color: myHexColor5,
      child: SafeArea(child: Scaffold(
        body: Column(
          children:  [
            const SizedBox(
              height: 6.0,
            ),
            const SearchAreaDesign(),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: screenSize.height > 810 ?screenSize.height-180: screenSize.height-150,
                  child: CustomScrollView(
                    slivers: [
                      SliverList(delegate: SliverChildBuilderDelegate(
                          (context,index)=> buildCategoriesButtons(categories[index], index),childCount: categories.length
                      ))
                    ],
                  )

                ),
                SizedBox(
                  height:screenSize.height > 810 ?screenSize.height-180: screenSize.height-150,
                  width: screenSize.width -101,
                  child:  Padding(
                    padding:  EdgeInsets.only(bottom:screenSize.height > 810? 22.0:42),
                    child: Stack(
                      children: [
                        Container(width:screenSize.width ,height: 0.5,color: Colors.grey[500],),

                        CustomScrollView(
                          anchor: 0.0,

                          slivers:<Widget> [
                            _buildTitle('Category'),
                           _buildListOfDepartments(departmentContent),

                            _buildTitle(showBrands?'Brands':''),
                            _buildListOfDepartments(showBrands?brandsContent:[]),

                            _buildTitle(departmentContent[0]['depName']),
                            _buildListOfDepartments(departmentContent),

                            _buildTitle(departmentContent[1]['depName']),
                            _buildListOfDepartments(departmentContent),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),

      ),),
    );
  }
  Widget _buildTitle(String title){
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
        Text(title,textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black)),
      ],
    ));
    // flexibleSpace: FlexibleSpaceBar(
    //   title: Text('AAAAAAAA',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black),),
    // ),
  }
  Widget _buildListOfDepartments(categories){
    return  SliverGrid(
      delegate: SliverChildBuilderDelegate(
              (context,index){
            return InkWell(
              onTap: ()async{
                 categoriesController.getListCategoryByCategory(categories[index]['depId']);
                Get.to(()=> ProductsOfDepartmentScreen(depId: categories[index]['depId'],haveChildren: categories[index]['hasChildren'],));
              },
              child: Padding(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 82,
                        width: 88,
                        //padding:  EdgeInsets.all(0.1),
                        decoration:  BoxDecoration(
                          color: myHexColor,
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                          child: Image.asset(
                            categories[index]['imagePath'].toString(),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(categories[index]['depName'].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                    ],
                  )),
            );

          },childCount: categories.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 0.8,
          crossAxisCount: 3),);

  }
}
