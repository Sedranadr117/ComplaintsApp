import 'package:complaint_app/config/extensions/navigator.dart';
import 'package:complaint_app/core/params/params.dart';
import 'package:complaint_app/features/complaints/presentation/bloc/add/add_complaint_bloc.dart';
import 'package:complaint_app/features/complaints/presentation/bloc/dropdown/dropdown_cubit.dart';
import 'package:complaint_app/features/complaints/presentation/bloc/show_all/show_all_complaints_bloc.dart';
import 'package:complaint_app/features/complaints/presentation/bloc/show_all/show_all_complaints_event.dart';
import 'package:complaint_app/features/complaints/presentation/widgets/custome_text_filed.dart';
import 'package:complaint_app/features/complaints/presentation/widgets/drop_menue_widget.dart';
import 'package:complaint_app/features/complaints/presentation/widgets/file_picker_widget.dart';
import 'package:complaint_app/features/complaints/presentation/pages/complaints_page.dart';
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

  List<PlatformFile> attachments = [];
  String? selectedType;
  String? selectedGovernorate;
  String? selectedAgency;

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
      body: BlocConsumer<AddComplaintBloc, AddComplaintState>(
        listener: (context, state) {
          if (state is AddComplaintSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('تم إرسال الشكوى بنجاح!')));
            locationComplaintController.clear();
            discriptionComplaintController.clear();
            solutionComplaintController.clear();
            setState(() {
              attachments = [];
              selectedType = null;
              selectedGovernorate = null;
              selectedAgency = null;
            });
            context.read<ComplaintsBloc>().add(
              GetAllComplaintsEvent(refresh: true),
            );

            context.popPage(HomePage());
          } else if (state is AddComplaintError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('حدث خطأ: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AddComplaintLoading;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  child: Column(
                    children: [
                      // الـ dropdowns والـ textfields كما هي
                      BlocProvider(
                        create: (_) => DropdownCubit<String>(),
                        child: CustomDropdown<String>(
                          label: 'اختر نوع الشكوى',
                          items: types,
                          onSelect: (item) => selectedType = item,
                        ),
                      ),
                      SizedBox(height: 20),
                      BlocProvider(
                        create: (_) => DropdownCubit<String>(),
                        child: CustomDropdown<String>(
                          label: 'اختر المحافظة',
                          items: governorates,
                          onSelect: (item) => selectedGovernorate = item,
                        ),
                      ),
                      SizedBox(height: 20),
                      BlocProvider(
                        create: (_) => DropdownCubit<String>(),
                        child: CustomDropdown<String>(
                          label: 'اختر الجهة الحكومية',
                          items: governmentAgencies,
                          onSelect: (item) => selectedAgency = item,
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        label: 'ادخل موقع الشكوى',
                        controller: locationComplaintController,
                        isIcon: true,
                        icon: Icons.location_on_outlined,
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
                        label: attachments.isEmpty
                            ? "اختر ملف (صورة أو PDF) - الحد الأقصى 10MB"
                            : attachments.length > 1
                            ? "${attachments.length} ملفات مختارة"
                            : "ملف مختار: ${attachments.first.name}",
                        maxFileSizeInMB: 10,
                        onFilePicked: (file) {
                          if (file != null) {
                            // Check total size of all attachments
                            final currentTotalSize = attachments.fold<int>(
                              0,
                              (sum, file) => sum + (file.size),
                            );
                            final newTotalSize = currentTotalSize + file.size;
                            final maxTotalSize = 50 * 1024 * 1024; // 50MB total

                            if (newTotalSize > maxTotalSize) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'إجمالي حجم الملفات كبير جداً (الحد الأقصى: 50MB)',
                                  ),
                                ),
                              );
                              return;
                            }

                            setState(() {
                              attachments.add(file);
                            });
                          }
                        },
                      ),
                      if (attachments.isNotEmpty) ...[
                        SizedBox(height: 12),
                        ...attachments.asMap().entries.map((entry) {
                          final index = entry.key;
                          final file = entry.value;
                          final fileSizeMB = (file.size / (1024 * 1024))
                              .toStringAsFixed(2);
                          return Container(
                            margin: EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.insert_drive_file,
                                  size: 20,
                                  color: Colors.grey.shade700,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        file.name,
                                        style: TextStyle(fontSize: 13),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '$fileSizeMB MB',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      attachments.removeAt(index);
                                    });
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                      SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (selectedType == null ||
                                      selectedGovernorate == null ||
                                      selectedAgency == null ||
                                      locationComplaintController
                                          .text
                                          .isEmpty ||
                                      discriptionComplaintController
                                          .text
                                          .isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "يرجى تعبئة جميع الحقول المطلوبة",
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  final params = AddComplaintParams(
                                    complaintType: selectedType!,
                                    governorate: selectedGovernorate!,
                                    governmentAgency: selectedAgency!,
                                    location: locationComplaintController.text
                                        .trim(),
                                    description: discriptionComplaintController
                                        .text
                                        .trim(),
                                    solutionSuggestion:
                                        solutionComplaintController.text.trim(),
                                    attachments: attachments,
                                  );

                                  context.read<AddComplaintBloc>().add(
                                    SendComplaintEvent(params),
                                  );
                                },
                          child: Text("إرسال الشكوى"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
