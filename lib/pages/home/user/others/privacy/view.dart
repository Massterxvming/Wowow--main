import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/config/app_strings.dart';

import 'logic.dart';

class PrivacyPage extends StatelessWidget {
  PrivacyPage({Key? key}) : super(key: key);

  final logic = Get.find<PrivacyLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(title: AppStrings.privacy),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 0, top: 15, left: 30, right: 30),
        child: SingleChildScrollView(
          child: Container(
            child: const Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: '隐私政策\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                      '\n北京第七界科技有限公司开发了该免费的应用程序WoWoW许愿啦。该服务由北京第七界科技有限公司提供，旨在安装并使用。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                      '\n我们对您使用WoWoW许愿啦的隐私政策做出规定，并解释了我们如何收集，保护和披露您因使用我们的服务而产生的信息。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                      '\n如果您选择使用我们提供的服务，则表示您同意收集和使用与此政策相关的信息。我们收集的个人信息用于提供和改进服务。除非本隐私政策中另有说明，否则我们不会与任何人一起使用或分享您的信息。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '\n信息收集与使用\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                      '\n为了获得更好的体验，在使用我们的服务时，我们可能会要求您向我们提供某些个人身份信息。这些信息包括但不限于',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),TextSpan(
                  text:
                      '手机号、文字与图片等多媒体信息',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),TextSpan(
                  text:
                      '我们请求的信息将由我们保留并按照本隐私政策的规定使用。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                      '\n我们收集信息的目的包括但不限于：',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),TextSpan(
                  text:
                      '为您提供注册、登录和身份验证功能；为您和其他用户提供交流平台；确保账户的安全性；为您提供客户支持和帮助；以及其他与提供服务相关的目的。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '\n软件自启动\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                      '\n为了确保我们的服务能够正确且高效地运行，在您的设备上，我们的应用程序WoWoW许愿啦可能会在开机时自动启动。自启动功能有助于为您提供即时的通知和更新，以及保证应用程序的正常运行。如果您不希望应用程序在开机时自动启动，您可以在设备的系统设置中关闭该功能。请注意，关闭自启动功能可能会影响应用程序的部分功能和您的使用体验。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '\n记录数据\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                      '\n当您使用我们的服务时，如果应用程序出现错误，我们会通过第三方数据统计在您的手机上收集数据和信息。该日志数据可能包含以下信息，例如：您的设备Internet协议（IP）地址，设备名称，操作系统版本，使用我们的服务时应用的配置，您使用该服务的时间和日期以及其他统计信息。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '\nCookies\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                      '\nCookies是具有少量数据的文件，通常用作匿名唯一标识符。这些信息将从您访问的网站发送到浏览器，并存储在设备的内存中。本应用未明确使用这些Cookies。但是，该应用程序可能使用第三方代码和使用带有Cookies的库来收集信息并改善其服务。您可以选择接受还是拒绝这些Cookies，并知道何时将Cookies发送到您的设备。如果您选择拒绝我们的Cookies，则可能无法使用本服务的部分功能。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '\n服务供应商\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '''\n我们可能由于以下原因雇用第三方公司和个人：
促进我们的服务质量；
代表我们提供服务；
提供与服务相关的服务；
帮助我们分析如何使用我们的服务。\n''',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                      '\n我们想通知此服务的用户，这些第三方有权访问您的个人信息。原因是代表我们执行分配给他们的任务。但是，他们有义务不出于任何其他目的披露或使用该信息。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '\n安全\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                      '\n我们很重视您对我们提供您的个人信息的信任，因此我们正在努力使用商业上可接受的方法来保护它。但是请记住，没有一种通过互联网传输的方法，或者说电子存储的方法是100%安全可靠的，我们不能保证它的绝对安全性。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '\n注销账号\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                      '\n我们重视您的用户隐私，当您在准备注销您的账号并在服务器中删除您的所有数据时，您可以在 “我的—注销账号” 中点击确认，以此来注销您的账号。请注意，此操作将注销您的账号，您账号中的所有信息将被清除，包括但不限于：添加的好友、愿望相关信息、想要相关信息、您和好友的互动数据。我们将在服务器中抹除您所有的相关信息。此操作不可逆，请您谨慎选择。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '\n到其他网站的链接\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                      '\n此服务可能包含指向其他网站的链接。如果你点击第三方链接，你将被引导到该网站。注意，这些外部站点不是由我们操作的。因此，我们强烈建议您查看这些网站的隐私策略。我们对任何第三方网站或服务的内容、隐私政策或做法没有控制权，也不承担任何责任。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '\n儿童隐私\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                      '\n这些服务不面向13岁以下的青少年。我们不会有意收集13岁以下儿童的个人身份信息。如果我们发现13岁以下的儿童向我们提供了个人信息，我们会立即从我们的服务器中删除这些信息。 如果您是父母或监护人，并且知道您的孩子向我们提供了个人信息，请与我联系，以便我们能够采取必要的措施。\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '\n本隐私政策的变更\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text:
                      '\n我们可能会不时更新我们的隐私政策。因此，建议您定期查看此页以了解更改。如有任何更改，我们会在本页公布新的隐私政策。该政策自2023-07-02起生效。\n',
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
