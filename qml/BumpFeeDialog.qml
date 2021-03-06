import Blockstream.Green 0.1
import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.12

ControllerDialog {
    title: qsTrId('id_increase_fee')
    property Transaction transaction
    readonly property Account account: transaction.account

    controller: BumpFeeController { }

    doneText: qsTrId('id_transaction_sent')
    minimumWidth: 300
    initialItem: FocusScope {
        property list<Action> actions: [
            Action {
                text: controller.tx.error !== '' ? qsTrId(controller.tx.error) : qsTrId('id_next')
                enabled: controller.tx && controller.tx.error === ''
                onTriggered: controller.bumpFee()
            }
        ]
        implicitHeight: layout.implicitHeight
        implicitWidth: layout.implicitWidth
        ColumnLayout {
            id: layout
            anchors.fill: parent
            SectionLabel {
                text: qsTrId('id_previous_fee')
            }
            Label {
                text: qsTrId('id_fee') + ': ' + formatAmount(transaction.data.fee) + ' ≈ ' +
                      formatFiat(transaction.data.fee)
            }
            Label {
                text: qsTrId('id_fee_rate') + ': ' + Math.round(transaction.data.fee_rate / 10 + 0.5) / 100 + ' sat/vB'
            }

            SectionLabel {
                text: qsTrId('id_new_fee')
            }
            Label {
                text: qsTrId('id_fee') + ': '  + formatAmount(controller.tx.fee) + ' ≈ ' +
                      formatFiat(controller.tx.fee)
            }
            Label {
                text: qsTrId('id_fee_rate') + ': ' + Math.round(controller.tx.fee_rate / 10 + 0.5) / 100 + ' sat/vB'
            }

            FeeComboBox {
                id: fee_combo
                Layout.fillWidth: true
                extra: [{ text: qsTrId('id_custom') }]
                onFeeRateChanged: {
                    if (feeRate) {
                        controller.feeRate = feeRate
                    }
                }
            }
            TextField {
                visible: fee_combo.currentIndex === 3
                onTextChanged: controller.feeRate = Number(text) * 1000
            }
        }
    }
}
