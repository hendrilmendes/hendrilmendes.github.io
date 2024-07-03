part of '../services.dart';

class _ServiceCardBackWidget extends StatelessWidget {
  const _ServiceCardBackWidget(
      {required this.serviceDesc, required this.serviceTitle});

  final String serviceDesc;
  final String serviceTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          serviceDesc,
          style: AppText.l1,
        ),
        const Divider(
          color: Colors.black38,
        ),
        SizedBox(
          height: AppDimensions.normalize(14),
          width: AppDimensions.normalize(60),
          child: FilledButton.tonal(
            onPressed: () => showDialog(
                context: context,
                builder: (contecxt) => AlertDialog(
                      title: Text(
                        "Contato:",
                        style: AppText.b2b,
                      ),
                      actions: [
                        FilledButton.tonal(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Voltar"),
                        )
                      ],
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            height: 40.0,
                            onPressed: () => openURL(
                              'https://api.whatsapp.com/send?phone=5565993611847&text=Ol%C3%A1%20Hendril,%20vi%20os%20seus%20projetos%20e%20gostaria%20de%20propor%20algo!',
                            ),
                            color: const Color(0xff34CB62),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.white,
                                ),
                                Space.x!,
                                Text(
                                  'WhatsApp',
                                  style: AppText.l1!.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Space.y1!,
                          MaterialButton(
                            height: 40.0,
                            onPressed: () => openURL(
                              'https://t.me/hendril_mendes',
                            ),
                            color: const Color.fromARGB(255, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.telegram,
                                  color: Color.fromARGB(255, 74, 58, 163),
                                ),
                                Space.x!,
                                Text(
                                  'Telegram',
                                  style: AppText.l1!.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
            child: Text(
              'CONTRATAR',
              style: AppText.b2!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
