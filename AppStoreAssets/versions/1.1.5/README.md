# 1.1.5 发布记录

- App 版本：1.1.5，构建号：12。
- 已归档并上传 App Store Connect；提交审核与正式上线状态以商店为准。
- 本版本沿用 `../1.1.4/generated/<locale>/` 的宣传图，不重复复制素材。
- 修复编辑读数丢失小数精度；编辑至少显示两位小数，并保留已有额外精度。
- 列表、趋势和参考范围的小数格式跟随 App 内选择的语言，而非系统地区。

## 商店名称与简短更新说明

| 语言 | 名称 | 副标题 | 更新说明 |
| --- | --- | --- | --- |
| zh-Hans | 尿酸记录 | 一款简洁的尿酸记录工具 | 修复了一些问题。 |
| en-US | Uric Acid Log | Simple readings and trends | Fixed some issues. |
| de | Harnsäure-Tagebuch | Werte einfach im Blick | Einige Fehler wurden behoben. |
| it | Diario Acido Urico | Registra e segui i valori | Corretti alcuni problemi. |
| fr | Journal Acide Urique | Mesures et tendances | Correction de quelques problèmes. |
| pt-PT | Diário Ácido Úrico | Registos e tendências | Corrigidos alguns problemas. |
| es | Diario Ácido Úrico | Mediciones y tendencias | Se han corregido algunos problemas. |

描述、关键词和截图沿用上一版。商店名称需要在 App 信息中单独设置，
不由 App 内语言设置控制。审核通过前线上名称可能仍显示旧值。

## 回归测试

```sh
python3 AppStoreAssets/tools/test_measurement_decimals.py
python3 AppStoreAssets/tools/test_trend_axis.py
```

七语言小数格式化/解析往返测试和趋势纵轴测试通过。
模拟器构建通过；临时 XCTest 验证新增、保存、编辑、再保存 `5,29`，
包括系统英语、App 内意大利语的组合。临时测试工程及归档位于 `/tmp`，
不作为仓库持久依赖，不提交构建包、签名资料或上传日志。
