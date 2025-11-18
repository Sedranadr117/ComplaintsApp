import 'package:complaint_app/features/complaints/presentation/bloc/dropdown_cubit.dart';
import 'package:complaint_app/features/complaints/presentation/widgets/custome_text_filed.dart';
import 'package:complaint_app/features/complaints/presentation/widgets/drop_menue_widget.dart';
import 'package:complaint_app/features/complaints/presentation/widgets/file_picker_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddComplaintsPage extends StatefulWidget {
  const AddComplaintsPage({super.key});

  @override
  State<AddComplaintsPage> createState() => _AddComplaintsPageState();
}

class _AddComplaintsPageState extends State<AddComplaintsPage> {
  final TextEditingController locationComplaintController =
      TextEditingController();
  final TextEditingController discriptionComplaintController =
      TextEditingController();
  final TextEditingController solutionComplaintController =
      TextEditingController();

  final List<String> types = [
    " تأخر في إنجاز معاملة",
    "	تعامل الموظف مقدم الخدمة",
    "	تعطل النظام التقني",
    "	تعقيد في الإجراءات",
    "	رسوم الخدمة",
    "	ضعف جودة الخدمة",
    "	طول مدة الانتظار",
    "	عدم الموافقة على الخدمة",
  ];
  final List<String> governorates = [
    "دمشق",
    "ريف دمشق",
    "حلب",
    "حمص",
    "اللاذقية",
    "حماة",
    "طرطوس",
    "دير الزور",
    "الحسكة",
    "الرقة",
    "إدلب",
    "السويداء",
    "درعا",
    "القنيطرة",
  ];
  final List<String> governmentAgencies = [
    "وزارة الإدارة المحلية والبيئة",
    "وزارة المالية",
    "وزارة الدفاع",
    "وزارة الاقتصاد والصناعة",
    "وزارة التعليم العالي",
    "وزارة الصحة",
    "وزارة التربية",
    "وزارة الطاقة",
    "أمانة رئاسة مجلس الوزراء",
    "وزارة الأشغال العامة والإسكان",
    "وزارة الاتصالات والتقانة",
    "وزارة الداخلية",
    "وزارة الزراعة",
    "وزارة الشؤون الاجتماعية والعمل",
    "وزارة الثقافة",
    "وزارة النقل",
    "وزارة العدل",
    "وزارة السياحة",
    "وزارة الإعلام",
    "وزارة الأوقاف",
    "نقابة المعلمين",
    "الاتحاد الرياضي العام",
    "الاتحاد العام للفلاحين",
    "مجلس الدولة",
    "وزارة التنمية الإدارية",
    "وزارة الخارجية والمغتربين",
    "وزارة الطوارئ والكوارث",
    "الهيئة العامة للمنافذ البرية والبحرية",
    "مصرف سوريا المركزي",
  ];

  PlatformFile? selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "إضافة شكوى",
          style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              children: [
                BlocProvider(
                  create: (_) => DropdownCubit<String>(),
                  child: CustomDropdown<String>(
                    label: 'اختر نوع الشكوى',
                    items: types,
                    onSelect: (item) {
                      print('تم اختيار: $item');
                    },
                  ),
                ),
                SizedBox(height: 20),
                BlocProvider(
                  create: (_) => DropdownCubit<String>(),

                  child: CustomDropdown<String>(
                    label: 'اختر المحافظة',

                    items: governorates,
                    onSelect: (item) {
                      print('تم اختيار: $item');
                    },
                  ),
                ),
                SizedBox(height: 20),
                BlocProvider(
                  create: (_) => DropdownCubit<String>(),

                  child: CustomDropdown<String>(
                    label: 'اختر الجهة الحكومية',

                    items: governmentAgencies,
                    onSelect: (item) {
                      print('تم اختيار: $item');
                    },
                  ),
                ),
                SizedBox(height: 20),

                CustomTextField(
                  label: 'ادخل موقع الشكوى',
                  controller: locationComplaintController,
                  isIcon: true,
                  icon: Icons.location_on,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  maxLines: 5,
                  label: 'ادخل وصف الشكوى',
                  controller: discriptionComplaintController,
                ),
                SizedBox(height: 20),

                CustomTextField(
                  label: 'اقترح حلاً',
                  controller: solutionComplaintController,
                ),
                SizedBox(height: 20),

                FilePickerWidget(
                  label: selectedFile == null
                      ? "اختر ملف (صورة أو PDF)"
                      : selectedFile!.name,
                  onFilePicked: (file) {
                    setState(() {
                      selectedFile = file;
                    });
                  },
                ),
                SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("إرسال الشكوى"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
