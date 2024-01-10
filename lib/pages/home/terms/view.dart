import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/widgets/app_tool_bar.dart';
import 'logic.dart';

class TermsPage extends StatelessWidget {
  TermsPage({Key? key}) : super(key: key);

  final logic = Get.find<TermsLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(title: '条款与条件'),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 0,top: 15,left: 30,right: 30),
        child: SingleChildScrollView(
          child: Container(
            child: const Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: '条款与条件\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,

                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                  '\n下载或使用该应用程序，此条款将自动适用于您——因此，请确保在使用该应用程序之前仔细阅读这些条款。您不得以任何方式复制或修改该应用程序、应用程序的任何部分及我们的商标。您无权尝试提取应用程序的源代码，也不应尝试将应用程序翻译成其他语言或制作派生版本。该应用程序本身以及与之相关的所有商标、版权、数据库权利和其他知识产权，仍属于北京第七界科技有限公司.\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,

                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                  '\n北京第七界科技有限公司致力于确保该应用程序尽可能有用和高效。因此，我们保留随时对应用程序进行更改或对其服务收费的权利。如果没有向您明确说明您支付的费用，我们永远不会向您收取应用程序或其服务费用。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,

                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                  '\nWoWoW许愿啦存储并处理您提供给我们的个人数据，以便提供我们的服务。确保您的手机和对应用程序的访问安全是您的责任。因此，我们建议您不要给您的手机越狱或root您的手机，这是删除软件限制和设备官方操作系统所施加的限制的过程。它可能会使您的手机容易受到恶意软件/病毒/恶意程序的攻击，从而损害您手机的安全功能，并且可能意味着WoWoW许愿啦无法正常运行或根本无法运行。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,

                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                  '\n您应该意识到，北京第七界科技有限公司在某些情况下不承担任何责任。应用程序的某些功能要求应用程序具有活动的internet连接。连接可以是Wi-Fi，也可以由您的移动网络提供商提供，但如果您无法访问Wi-Fi，并且您没有任何剩余的数据空间，则北京第七界科技有限公司无法对应用程序无法完全正常工作承担责任。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,

                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                  '\n如果您在Wi-Fi区域外使用该应用程序，您应该记住，您与移动网络提供商的协议条款仍然适用。因此，您的移动提供商可能会向您收取访问应用程序时连接期间的数据成本或其他第三方费用。在使用该应用程序时，您将承担任何此类费用，包括漫游数据费用，前提是您在不关闭数据漫游的情况下在您的母国（即地区或国家）之外使用该应用程序。如果您不是正在使用应用程序的设备的付款人，请注意，我们假设您已收到付款人使用该应用程序的许可。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,

                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                  '\n同样，北京第七界科技有限公司也不能总是对你使用应用程序的方式负责，也就是说，你需要确保你的设备保持充电状态——如果电池用完了，你不能打开它来使用服务，北京第七界科技有限公司不能承担责任。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,

                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                  '\n关于北京第七界科技有限公司对您使用该应用程序的责任，当您使用该应用程序时，请务必记住，尽管我们努力确保它在任何时候都是更新和正确运行的，但我们依赖第三方向我们提供信息，以便我们可以向您提供信息。北京第七界科技有限公司对于您因完全依赖应用程序的此功能而遭受的任何直接或间接损失，概不负责。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,

                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                  '\n在某个时候，我们可能希望更新应用程序。应用程序的需求可能会发生变化，并且如果您想继续使用该应用程序，则需要下载更新。 北京第七界科技有限公司不保证应用程序将始终更新，使其与您相关和或与您设备上安装的版本可以使用。但是，您保证在提供给您时始终接受该应用程序的更新。我们也可能停止提供该应用程序，并且可以在不通知您终止的情况下随时终止其使用。除非我们另行告知，否则在任何终止后，（a）这些条款授予您的权利和许可将终止；（b）您必须停止使用该应用程序，并且（如果需要）将其从设备中删除。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,

                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),

                TextSpan(
                  text: '\n本条款和条件的变更\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,

                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '\n我们可能会不时更新我们的条款和条件。因此，建议您定期查看此页以了解更改。如有任何更改，我们会在本页公布新的条款和条件。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,

                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),TextSpan(
                  text: '\n这些条款和条件自2023-07-02起生效。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,

                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '\n联系我们\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,

                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                  '\n如果您对我们的隐私政策有任何疑问或建议，请随时通过jhay2000@foxmail.com与我们联系。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(text: '\n\n\n\n')
              ],
            )),
          ),
        ),
      ),
    );
  }
}
