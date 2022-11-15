# Changelog

Notable changes to the Glacier Thickness Database (GlaThiDa) are documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/). This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html), adapted for data. Given a version number `major.minor.patch`, increment the `major` version when data is added, increment the `minor` version when existing data is changed, and increment the `patch` version when metadata is changed (but data is left unchanged).

The database tables and fields therein are referred to in the format `table.field` (e.g. `T`, `T.MEAN_THICKNESS`). The table name is sometimes dropped if the field name occurs in only one table, or when referring to the field of that name across all tables. Integers in square brackets (e.g. [123, 456]) refer to the `GlaThiDa_ID` of the impacted surveys. Links to the corresponding commit, issue, or merge request are included when possible.

## 3.1.0 (2020-10-06)

### Structure: Fixed
- Update the link for the working group on glacier ice thickness estimation (https://cryosphericsciences.org/activities/ice-thickness). https://gitlab.com/wgms/glathida/-/issues/1
- Use lowercase resource names in foreign key definitions to match resource names. https://gitlab.com/wgms/glathida/-/commit/dfe947b7a52b9abf579448c0064def184dad1832
- Change date fields to `string`, since the use of "99" to designate unknown days or months results in invalid dates. https://gitlab.com/wgms/glathida/-/commit/e0c3ba641d024c3dac19f5cf5cfb71e6a46d029a
- Move field constraints into the `constraints` property, in accordance with the Frictionless Data Table Schema (https://frictionlessdata.io/specs/table-schema). https://gitlab.com/wgms/glathida/-/commit/a1dc9c64c2b4e930413c7eb1a6a3ad6b6b908f17
- Replace `maxLength` constraints on `integer` fields with the equivalent `maximum` constraint (e.g. `maxLength: 4` to `maximum: 9999`), in accordance with the Frictionless Data Table Schema (https://frictionlessdata.io/specs/table-schema). https://gitlab.com/wgms/glathida/-/commit/60e83e0ecf980f7a53db13176fbb7ddc7d845ba2
- Fix contributor affiliations. https://gitlab.com/wgms/glathida/-/commit/968201b973b764d896e8f60f927d25d4f684f320

### Structure: Changed
- Replace `inLanguage` property (https://schema.org/inLanguage) with `languages` property, in accordance with the Frictionless Data pattern for language support (https://frictionlessdata.io/specs/patterns/#language-support). https://gitlab.com/wgms/glathida/-/commit/77e9be60485dbc13903782fd67745ee75ea88073
- Reduce `maximum` of all elevation and thickness fields from 999999 m to 9999 m. https://gitlab.com/wgms/glathida/-/commit/933c0deeaa764443ba9f57d6413fe60534ef3a1a
- Change foreign keys from `["GlaThiDa_ID"]` to `["GlaThiDa_ID", "POLITICAL_UNIT", "GLACIER_NAME"]` to ensure that repeated fields match across tables. https://gitlab.com/wgms/glathida/-/commit/45882709c688dacd2cc5714eec1e1b21c2a01f5a
- Replace primary keys for `TT` and `TTT` with the equivalent unique keys to allow `null` values, in accordance with the format supported by https://github.com/ezwelty/goodtables-pandas-py. https://gitlab.com/wgms/glathida/-/commit/06a9f536f3a20051d1df82f020cf2a09aa1c552c
- Add a pattern constraint on freeform string fields (`SURVEY_METHOD_DETAILS`, `SPONSORING_AGENCY`, `REFERENCES`, and `REMARKS`) to forbid double quotes ("), line breaks (\n), and carriage returns (\r). These characters are not universally supported by CSV implementations. https://gitlab.com/wgms/glathida/-/commit/7a12a5bd7100a05ef6cc07ef0d3d0c15e8514d84
- Add or adjust pattern constraints to forbid leading and trailing white space (\s) and double spaces (  ) in string fields. https://gitlab.com/wgms/glathida/-/commit/4489465fc362afe8214bc1f0789c1c8981db68a8
- Add pattern constraint to `GLACIER_ID` to forbid white space (\s) and double quotes ("). https://gitlab.com/wgms/glathida/-/commit/4489465fc362afe8214bc1f0789c1c8981db68a8
- Replace ad-hoc license with [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/), in accordance with the [GTN-G data policy](https://www.gtn-g.ch/data_policy/). https://gitlab.com/wgms/glathida/-/issues/12
- Change field `pattern` constraints to XML Schema syntax, as now required by Table Schema (https://specs.frictionlessdata.io/table-schema). https://gitlab.com/wgms/glathida/-/commit/32cb254d691e9be6188690de37c905f1bbb1a8fe
  - Remove `^` and `$` anchors.
  - Replace non-capture (`(?: )`) with standard groups (`( )`).
  - Remove escapes (`\`) for `:`, `/`, and `'`.
- Clarify the transliteration instructions for `GLACIER_NAME`. https://gitlab.com/wgms/glathida/-/commit/2269559249e18c1f3ded832101e04e0e5b1051b9

### Structure: Added
- Add a link to the repository (https://gitlab.com/wgms/glathida) and issue-reporting instructions. https://gitlab.com/wgms/glathida/-/issues/23
- Add "DRI" (drilling) to the allowed values for `SURVEY_METHOD` and use for Koerner & Paterson 1974 (https://doi.org/10.1016/0033-5894(74)90015-5) [325] ("electrothermal" drilling). https://gitlab.com/wgms/glathida/-/issues/9
- Add "EM" (electromagnetic) to the allowed values for `SURVEY_METHOD` and use for Finn et al. 2012 (https://doi.org/10.3189/2012JoG11J098) [500, 6628]. https://gitlab.com/wgms/glathida/-/issues/7
- Add links to GlaThiDa publications. https://gitlab.com/wgms/glathida/-/commit/d6b374811ca82f1f3444af8e24878ff4f37a1021

### Data: Removed
- Remove entries with only summary data superseded by surveys with point measurements. https://gitlab.com/wgms/glathida/-/merge_requests/4
- Remove modeled glacier-wide thicknesses. https://gitlab.com/wgms/glathida/-/commit/129aded4db5df1d8b187369bf9f644e5d6f25af8, https://gitlab.com/wgms/glathida/-/commit/505baa99dd4a6f38ee9961b5d45ccec5ce8c5a12
  - [353, 355] Mean and maximum thicknesses derived from modeling. See Table 4 in Farinotti et al. 2009 (https://doi.org/10.3189/002214309788816759).
  - [327] Mean and maximum thicknesses estimated from surface topography. See pages 104-105 in Aleynikov et al. 2002 (https://doi.org/10.2166/nh.2002.0006).

### Data: Fixed
- Restore values to columns `T.GLACIER_DB` and `T.ELEVATION_DATE`, which were accidentally cleared in v3.0.0. https://gitlab.com/wgms/glathida/-/issues/14
- Fix misplaced glacier centerpoints (`T.LAT`, `T.LON`) and update `POLITICAL_UNIT` as needed for all glacier surveys without point measurements. https://gitlab.com/wgms/glathida/-/merge_requests/3
- Change `POLITICAL_UNIT` (`T`, `TTT`) from "SJ" (Svalbard and Jan Mayen) to "NO" (Norway) [218, 342-345, 433-434, 2057-2063, 2065-2071]. https://gitlab.com/wgms/glathida/-/commit/dbf20ceeea5bc0a54f9c54f5798a4c6cef29309e
- Change `TTT.ELEVATION` from "9999" or "10000" to missing [2218, 2377, 2446, 2471, 2477]. https://gitlab.com/wgms/glathida/-/commit/6f7e3850d42c9f3c3e20b809fe650dcb66d6b810
- Add `T.DATA_FLAG` "1" and add to `T.REMARKS` that "according to Dowdeswell et al. 1984 (https://doi.org/10.3189/S0022143000008431), Macheret and Zhuravlev 1982 (https://doi.org/10.3189/S0022143000011643) wrongly interpreted the interface between cold and temperate ice as the bed on many glaciers" [109-167]. https://gitlab.com/wgms/glathida/-/issues/4
- Add `TTT.DATA_FLAG` "1" for an extreme outlier (2530 m thickness) on a glacier in Austria [1961]. The outlier is present in the original published dataset (https://doi.pangaea.de/10.1594/PANGAEA.849446). https://gitlab.com/wgms/glathida/-/commit/b51b34315ff8f380cafcb552dcf90b55e55c863f
- Change negative `TTT.THICKNESS` to "0" [497, 2766, 2771-2772, 2774, 2779, 2781-2786, 2790-2793, 2795-2800, 3766, 3790, 3792, 3794, 3798-3799, 3806, 3823, 3858, 3875, 3906, 3935, 3989, 4010, 4022, 4028-4029, 4031, 4050, 4075, 4084, 4102-4103, 4105, 4110, 4117, 4123, 4141, 4146, 4156, 4158, 4168, 4171, 4199, 4206-4207, 4220, 4227, 4229, 4238-4239, 4252, 4260, 4271, 4312-4313, 4328, 4335, 4337, 4350, 4372, 4374, 4379, 4386, 4397, 4408, 4427, 4432, 4434, 4436, 4438-4440, 4443-4445, 4451-4452, 4455, 4458, 4460, 4482, 4498, 4540, 4546-4547, 4557, 4560-4561, 4571, 4573, 4578, 4598, 4616, 4626, 4628, 4641, 4681, 4683, 4707, 4711, 4713, 4723, 4726, 4728, 4740, 4753, 4771, 4775, 4814, 4821, 4826, 4864, 4866, 4868, 4871, 4894, 5024, 5030, 5050, 5052, 5057, 5062, 5077, 5148, 5154, 5198, 5212, 5241, 5264, 5328-5329, 5331, 5389, 5397, 5406, 5453, 5460, 5471, 5478, 5504-5505, 5515, 5528, 5552, 5554, 5563-5564, 5583, 5585, 5591-5592, 5599, 5625, 5633, 5672, 5679, 5683, 5689, 5710, 5713, 5718, 5724, 5805, 5830, 5840, 5844, 5855, 5872, 5892, 5896, 5938, 5951-5953, 5958, 5965, 5969, 6005]. https://gitlab.com/wgms/glathida/-/commit/30596925438b5e78dae536542c1072a7408c4dfe
- Remove `T.DATA_FLAG` when both `T.MEAN_THICKNESS` and `T.MAX_THICKNESS` are missing [2095]. https://gitlab.com/wgms/glathida/-/issues/3
- Change `T.SURVEY_DATE` to match the earliest date in `TTT.SURVEY_DATE` [2057, 2060, 2062, 2319]. https://gitlab.com/wgms/glathida/-/commit/3912dfe4a1a54a4eabf31aa31df12a8976cf72c9
- Split [497] (Findelengletscher, Switzerland) into three surveys with different years and methods [6624-6626], leaving glacier-wide and elevation band estimates in place [497]. NOTE: [497] does not match newer published results (https://doi.org/10.5194/gh-73-1-2018). https://gitlab.com/wgms/glathida/-/issues/8
- Split [1976] (Mullwitzkees, Austria) into two surveys with different years [6630-6631]. Assign glacier-wide estimates to the 1998 survey containing all but one measurement [6630]. https://gitlab.com/wgms/glathida/-/issues/8
- Split [499] (Mount Adams, United States) into three surveys with different years and methods [6627-6629]. Assign `T.AREA`, `T.MEAN_SLOPE`, and `T.MEAN_THICKNESS` to the helicopter electromagnetic survey [6628] and `T.MAXIMUM_THICKNESS` to the radar survey [6629].
- Remove `T.MEAN_THICKNESS_UNCERTAINTY` when `T.MEAN_THICKNESS` is missing [1937]. https://gitlab.com/wgms/glathida/-/commit/85af87be0f13b3cc7481e005a8c93d6c47c12656
- Remove duplicate spaces and leading and trailing white space from string fields (`T`) [1-3, 94-96, 99, 103, 107-108, 491-496, 1947-1975, 1977-2010, 2027-2044, 2065-2071, 2082, 2104-2107, 2123, 2312, 2323, 2337, 2340, 2378, 2451, 6630-6631], (`TT`) [2086]. https://gitlab.com/wgms/glathida/-/commit/4489465fc362afe8214bc1f0789c1c8981db68a8
- Move survey method details in `T.REMARKS` to `T.SURVEY_METHOD_DETAILS` [200, 202, 224, 324, 327, 341, 466, 500, 510, 555-559, 2078-2079, 2081]. https://gitlab.com/wgms/glathida/-/commit/28b52dc8b6bebf2e253d92dab378aa8310ddda90
- Add or change `SURVEY_METHOD` based on references: https://gitlab.com/wgms/glathida/-/commit/5c610e32e35953311bb6eddd910a3f95472acc05
  - Change `SURVEY_METHOD` from "OTH" to "GPRa" [2081]. NOTE: Subset of NASA IceBridge MCoRDS data. Remove when imported for Antarctic Peninsula glaciers outside of Randolph Glacier Inventory coverage.
  - Add `SURVEY_METHOD` "GPR" (based on https://doi.org/10.3189/S0260305500001142, Table II footnote) and add https://doi.org/10.1080/02723646.1991.10642421 to `REFERENCES` [6].
  - Change `SURVEY_METHOD` from "OTH" to "GPRt" (based on https://doi.org/10.1080/02723646.1993.10642488), clear `SURVEY_METHOD_DETAILS`, add `INTERPOLATION_METHOD` "OTH", explain in `T.REMARKS` how `T.MEAN_THICKNESS` was interpolated, and fix author name in `REFERENCES` from "Nafz" to "Naftz" [200].
  - Add `SURVEY_METHOD` "GPRt" (based on https://pdfs.semanticscholar.org/f5d9/96286df30e26a6d535a32c4c6922aadc8e1c.pdf), remove `SURVEY_METHOD_DETAILS`, add `INTERPOLATION_METHOD` "OTH", and explain in `T.REMARKS` how `T.MEAN_THICKNESS` was interpolated [202].
  - Add `SURVEY_METHOD` "GPRt" (based on https://doi.org/10.3189/S002214300001340X) [203].
  - Add `SURVEY_METHOD` "GPRa" (based on https://doi.org/10.3189/S002214300001025X) [204].
  - Add `SURVEY_METHOD` "GPRt" (based on https://doi.org/10.1002/esp.3290180608) [422].
  - Add `SURVEY_METHOD` "GPRt" (based on `SURVEY_METHOD_DETAILS` and https://www.dartmouth.edu/ooc/the-stretch/science-on-a-glacier.html) [2094].
  - Change `SURVEY_METHOD` from "OTH" to "GPRt" (based on `SURVEY_METHOD_DETAILS` and https://doi.org/10.3189/2014AoG66A102) [2101].
- Convert `TOTAL_LENGTH_OF_SURVEY_PROFILES` from m to km [2085-2089], based on point coordinates (`TTT`) and Figure 2 in Li et al. 2012 (https://doi.org/10.1029/2011JF002104). https://gitlab.com/wgms/glathida/-/commit/e6eb92e66dd57ac787f7661c33fe39bb1a08e60d
- Add or change survey properties based on references:
  - Nikitin et al. 2000, Table 1 (http://www.webgeo.ru/books/MGI/88.pdf, page 145) [371, 392]. https://gitlab.com/wgms/glathida/-/commit/45702305cf36a5e2be06bd21d0403898a59f0d1a
  - Huss et al. 2008 (https://doi.org/10.1002/hyp.7055) [2186]. https://gitlab.com/wgms/glathida/-/commit/e1f16b566370e3454adee1712970ae477f5e0169
  - Saintenoy et al. 2013 (https://doi.org/10.3997/1873-0604.2012040) [2328]. https://gitlab.com/wgms/glathida/-/commit/19ffdfd89527823e88b9a0c3459c6defe1b0e300
  - Lapazaran et al. 2013 (http://doi.org/10.3402/polar.v32i0.11068) [2240]. https://gitlab.com/wgms/glathida/-/commit/f1d9eb92dac5978d5d39b92684d3cb3acf0fc99d
  - Lapazaran et al. 2013 (https://escholarship.org/uc/item/3kz922w7) [2084]. https://gitlab.com/wgms/glathida/-/commit/f5c04c73f50fd3a5b623a8bd3b8c05fa89fa6211
  - Macheret et al. 1988, Table 4 (http://www.webgeo.ru/books/MGI/62.pdf, page 66) [48, 49, 61, 91, 92]. https://gitlab.com/wgms/glathida/-/commit/4a8e1c17b785b6799ff7a0d9873383c32b3d7b4f
  - Zhuravlev 1985, Table 1 (http://www.webgeo.ru/books/MGI/52.pdf, page 242) [48, 49]. https://gitlab.com/wgms/glathida/-/commit/319a1e280872cf526a9cdc7e4dfe7665e6038f2e
  - Wilson et al. 2013 (https://doi.org/10.1002/jgrf.20096) [2078, 2079]. https://gitlab.com/wgms/glathida/-/commit/e7648aa5fbbfbdd77365d6a3c3f77e6c0345d2c0  
  - Nolan et al. 1995 (https://doi.org/10.3189/S0022143000034870) [224]. https://gitlab.com/wgms/glathida/-/commit/27d3ca6dda8bb6a6617b603b9ab09e605c1890cd
  - Anderton, P. W. (1975) Tasman Glacier 1971-73, Hydrological Research Annual Report 33. Ministry of Works and Development for the National Water and Soil Conservation Organisation. Section 2.2 [2082]. https://gitlab.com/wgms/glathida/-/commit/80e719384dd27cb2aeac638147617777b727f301
  - Dowdeswell et al. 2002 (https://doi.org/10.1029/2000JB000129) [339]. https://gitlab.com/wgms/glathida/-/commit/0b9d86de9a45c78520b9469ff82f8cbc5d56cdfa
  - Pettersson et al. 2011 (https://doi.org/10.1111/j.1468-0459.2011.00438.x) [510]. https://gitlab.com/wgms/glathida/-/commit/467e7dd5cb52d8b2162bf1d52bd2c3463ed67c90
  - Martín-Español et al. 2016 (https://doi.org/10.1017/jog.2016.95) [510]. https://gitlab.com/wgms/glathida/-/commit/467e7dd5cb52d8b2162bf1d52bd2c3463ed67c90
- Change `SURVEY_METHOD` and `SURVEY_METHOD_DETAILS` for mixed-method radar surveys based on references [324, 341, 510, 555-559]. https://gitlab.com/wgms/glathida/-/commit/22f7ada5a838f198719191d59ff5bd1f8c8896ad
- Change `REFERENCES` from Bauder et al. 2003 (https://doi.org/10.3189/172756403781815852), which predates the 2012 survey, to Rutishauser et al. 2016 (https://doi.org/10.1190/geo2015-0144.1) [2184]. https://gitlab.com/wgms/glathida/-/commit/00d249ffd409fd5b2dddd8d7f67b9d5b2be7e258
- Replace references to fields in `T.REMARKS` with their field name (e.g. change "avg. slope" to "MEAN_SLOPE"). https://gitlab.com/wgms/glathida/-/commit/9b9e152c726954f1c62126281a8d6f3a6460fe2a
- Remove `INTERPOLATION_METHOD` for surveys with no interpolated thickness [2078, 2079]. https://gitlab.com/wgms/glathida/-/commit/7ad46a1c337792c5de53bb5be086c918fdcdb758
- Change DOI in `REFERENCES` (and accordingly, in `datapackage.json` and `README.md`) from "*/glamos.thickness.1999_2015.r2018" to "10.18750/icethickness.2018.r2018" [2125-2147, 2149-2187]. https://gitlab.com/wgms/glathida/-/commit/e5e50fe8c3774eec0336bb293e9e0db5010daffa

### Data: Changed
- Change `REFERENCES` to the more detailed Bamber & Dowdeswell 1990 (https://doi.org/10.3189/S002214300000558X) [2401]. https://gitlab.com/wgms/glathida/-/commit/aa69a5b953e8cf30be1c3a0370e7dc17d9cf0851
- Replace repeat double quotes ("") in `T.REMARKS` with single quotes (') [2085-2089, 2099, 2118]. https://gitlab.com/wgms/glathida/-/commit/59e264772b1f76227f15c41023bf0e1f378b0c71

## 3.0.1 (2019-03-12)

### Structure: Fixed
- Switch the affiliations of Evgeny Vasilenko ("Academy of Sciences of Uzbekistan, Uzbekistan") and Rein Vaikmäe ("Tallinn University of Technology, Estonia").
- Use accents in contributor name "Francisco Machío".
- Fix link to external data source ("https://doi.org/10.0.73.62/glamos.thickness.1999_2015.r2018").

### Structure: Changed
- Use official Spanish names in the affiliations of Francisco Navarro ("Universidad Politécnica de Madrid: Escuela Técnica Superior de Ingeniería de Telecomunicación (ETSIT), Spain") and Javier Lapazaran ("Universidad Politécnica de Madrid, Spain"), as requested by Francisco Navarro.
- Update the affiliation of Francisco Machío ("Universidad Internacional de La Rioja (UNIR), Spain"), as requested by Francisco Navarro.

## 3.0.0 (2019-02-01)

### Structure: Added
- Format data as a Frictionless Data [Data Package](http://frictionlessdata.io/specs/data-package/). Add metadata and schemas to the required `datapackage.json`.
- Add this changelog as `CHANGELOG.md`.
- Add "GPR" to allowed values for `T.SURVEY_METHOD`. Change "GPRa/GPRt" to "GPR" [2030]. Change "GPRa" to "GPR" (`T.REMARKS`: "GPRt also conducted") [497].
- Add optional field `TTT.PROFILE_ID`. Populate for existing surveys by splitting `TTT.POINT_ID`:
  - [319] `TTT.POINT_ID`: "B1" → `TTT.PROFILE_ID`: "B", `TTT.POINT_ID`: "1"
  - [466] `TTT.POINT_ID`: "0_1" → `TTT.PROFILE_ID`: "0", `TTT.POINT_ID`: "1"
  - [499, 500] `TTT.POINT_ID`: "L20050.1" → `TTT.PROFILE_ID`: "L20050", `TTT.POINT_ID`: "1"
  - [554] `TTT.POINT_ID`: "BH1" → `TTT.PROFILE_ID`: "BH", `TTT.POINT_ID`: "1"
  - [2058] `TTT.POINT_ID`: "S6-1" → `TTT.PROFILE_ID`: "S6", `TTT.POINT_ID`: "1"
  - [2088, 2089] `TTT.POINT_ID`: "E1" → `TTT.PROFILE_ID`: "E", `TTT.POINT_ID`: "1"

### Structure: Changed
- Limit `POLITICAL_UNIT` to [ISO-3166-Alpha-2 country codes](https://www.iso.org/obp/ui/#search/code/).
- Extend `GLACIER_NAME` character limit from 30 to 60.
- Limit `GLACIER_NAME` characters to A-Z (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z), 0-9 (0, 1, 2, 3, 4, 5, 6, 7, 8, 9), - (dash), . (period), : (colon), () (parentheses), / (forward slash), ' (apostrophe), and  (space).
- Extend `GLACIER_ID` character limit from 12 to 14 to accommodate Randolph Glacier Inventory (RGI) identifiers.
- Extend `POINT_ID` character limit from 6 to 8 to accommodate point identifiers with longer formats.
- Make `SURVEY_DATE` an optional field. Change all `SURVEY_DATE` (`T`, `TT`, `TTT`) from "99999999" to "" [5-6, 33-49, 94-95, 99, 103, 107-165, 194-195, 197-211, 308, 310, 314-316, 325-326, 422, 467-485, 501, 505-506, 529-553].
- In the case of multiple dates for `SURVEY_DATE` (`T`, `TT`) and `DEM_DATE`, specify that the first date should be listed.
- Remove character limit for `REMARKS`, `SURVEY_METHOD_DETAILS`, `INVESTIGATOR`, `SPONSORING_AGENCY` and `REFERENCES`.
- Remove numeric limit for `NUMBER_OF_SURVEY_POINTS` and `NUMBER_OF_SURVEY_PROFILES`.
- Implicitly require that both (or neither) `SOURCE_ID` and `GLACIER_ID` be provided by requiring that `SOURCE_ID` specify the database used as the source for `GLACIER_ID`. Change all `T.SOURCE_ID` to "" where `GLACIER_ID` is "" [6, 9, 11-15, 17-24, 27, 32, 45, 68-72, 74-77, 80-90, 117, 121-122, 127-130, 132-134, 136, 154-155, 158, 160, 162-193, 200, 206, 214-218, 229-233, 236, 250, 321, 324, 328, 331-332, 335, 339-340, 352, 357, 359-361, 366, 399, 411, 422-423, 426-428, 446-447, 455, 460-468, 472, 480, 491-496, 499-504, 510, 512, 513, 515-516, 560, 1937, 2027-2055, 2083].
- Rename `SOURCE_ID` to `GLACIER_DB` to clarify that it is the database to which `GLACIER_ID` is meant to refer to. Change "SOURCE_ID" to "GLACIER_DB" in `T.REMARKS` [2104, 2107-2108].
- Rename `DEM_DATE` to `ELEVATION_DATE` to clarify that it is the date of the provided elevations, regardless of whether the elevations were extracted from a digital elevation model (DEM). Change "DEM_DATE" to "ELEVATION_DATE" in `T.REMARKS` [2091].

### Structure: Removed
- Header lines containing a table label (e.g. "TTT GLACIER THICKNESS POINT DATA") and field codes (e.g. "TTT1") in `TT` and `TTT`, and a line containing field units (e.g. "numeric code") in `T`, `TT` and `TTT`. Having a single header line with field names (e.g. "GlaThiDa_ID,...") maximizes the machine-readability of the data files.

### Data: Added
- Survey (`T`, `TT`, `TTT`) of Athabasca Glacier, Canada submitted by Ian Raphael [2094]. `T.INVESTIGATOR` also lists Robert Hawley.
- Survey (`T`, `TT`, `TTT`) of Lötschengletscher, Switzerland submitted by Eliane Brändle and Enrico Mattea [2095].
- Surveys (`T`, `TT`, `TTT`) of glaciers in China submitted by Huilin Li [2096-2100].
- Survey (`T`, `TTT`) of Qaanaaq Ice Cap, Greenland submitted by Izumi Asaji [2101]. `T.INVESTIGATOR` lists Shin Sugiyama.
- Surveys (`T`, `TTT`) of glaciers in Greenland submitted by Jakob Abermann [2102-2103]. `T.INVESTIGATOR` also lists Jakob Steiner, Rainer Prinz, and Peter Lisager.
- Surveys (`T`, `TTT`) of glaciers in Norway compiled and submitted by Liss M. Andreassen [2104-2108]. `T.INVESTIGATOR` lists Kjetil Melvold and Michael Kennett.
- Surveys (`T`, `TTT`) of glaciers in Svalbard and Kazakhstan submitted by Ivan Lavrentiev [2109-2122].
- Survey (`T`, `TTT`) of Aldegondabreen, Svalbard submitted by Francisco Navarro [2123].
- Survey (`T`, `TT`, `TTT`) of Mount Kilimanjaro, Tanzania submitted by Pascal Bohleber [2124] (https://doi.org/10.1594/PANGAEA.849390).
- Surveys (`T`, `TTT`) of glaciers in Switzerland submitted by Andreas Bauder and Matthias Huss [2125-2187] (https://doi.org/10.18750/glamos.thickness.1999_2015.r2018).
- Surveys (`T`, `TTT`) of glaciers in Svalbard compiled and submitted by Francisco Navarro and Johannes Fürst [2188-2499] (including https://doi.org/10.21334/npolar.2017.702ca4a7). `T.INVESTIGATOR` also lists the following:
  - Julian A. Dowdeswell and Toby J. Benham - Scott Polar Research Institute, United Kingdom
  - Rickard Pettersson - Uppsala University, Sweden
  - Jacek Jania, Mariusz Grabiec - University of Silesia in Katowice, Poland
  - Javier Lapazaran, Francisco Machio - Technical University of Madrid, Spain
  - Evgeny Vasilenko - Academy of Sciences of Uzbekistan, Uzbekistan
  - Victor S. Zagorodnov, Serguei M. Arkhipov, Vladimir Kotlyakov - Russian Academy of Sciences: Institute of Geography, Russia
  - Thomas V. Schuler, Svein-Erik Hamran, Jon Ove Hagen - University of Oslo, Norway
  - Kjetil Melvold - Norwegian Water Resources and Energy Directorate (NVE), Norway
  - Helgi Björnsson, Finnur Pálsson - University of Iceland, Reykjavik
  - David Rippin - University of York, United Kingdom
  - Albane Saintenoy - University of Paris-Sud, France
  - Songtao Ai - Wuhan University, China
  - Douglas I. Benn, Heïdi Sevestre - University of Saint Andrews, United Kingdom
  - Jack Kohler, Katrin Lindbäck, Elisabeth Isaksson - Norwegian Polar Institute, Norway
  - Yoshiyuki Fujii - National Institute of Polar Research, Japan
  - Rein Vaikmäe - Tallinn University of Technology, Estonia
  - Steen Savstrup Kristensen - Technical University of Denmark: Department of Space Research and Space Technology (DTU Space), Denmark
  - Ya.-M.K. Punning - Estonian Academy of Sciences (USSR Academy of Sciences-Estonia): Institute of Geology, Estonia
- Surveys (`T`, `TTT`) of glaciers in Greenland, Canada, Antarctica, Svalbard and the United States (Alaska) extracted from IceBridge data intersected with Randolph Glacier Inventory (RGI6.0) glacier outlines [2500-6623].
  - [Pre-IceBridge MCoRDS L2 Ice Thickness, Version 1](https://doi.org/10.5067/QKMTQ02C2U56) (1993-06-23 to 2007-09-23)
  - [IceBridge MCoRDS L2 Ice Thickness, Version 1](https://doi.org/10.5067/GDQ0CUCVTE2Q) (2009-10-16 to 2017-11-25)
  - [IceBridge HiCARS 1 L2 Geolocated Ice Thickness, Version 1](https://doi.org/10.5067/F5FGUT9F5089) (2009-01-02 to 2010-12-21)
  - [IceBridge HiCARS 2 L2 Geolocated Ice Thickness, Version 1](https://doi.org/10.5067/9EBR2T0VXUDG) (2010-12-05 to 2013-01-20)
  - [IceBridge PARIS L2 Ice Thickness, Version 1](https://doi.org/10.5067/OMEAKG6GIJNB) (2009-04-01 to 2009-05-02)
  - [IceBridge WISE L2 Ice Thickness and Surface Elevation, Version 1](https://doi.org/10.5067/0ZBRL3GY720R) (2012-03-16 to 2012-03-25)

### Data: Removed
- Surveys (`T`, `TTT`) extracted from IceBridge data intersected with Randolph Glacier Inventory (RGI3.2) glacier outlines [1000-1932].
- Elevation bands (`TT`) with missing `TT.MEAN_THICKNESS` (required field) [2012, 2093: previously 2010 CHARQUINI SUR].
- Survey (`T`, `TTT`) of JOSTEDALSBREEN [2064], which has incorrect surface elevations. It is replaced by [2108].
- Survey (`T`) of SILVRETTA [354]. It is replaced by [2171], which includes point-level data.
- Surveys (`T`) of KONGSVEGEN, UVERSBREEN, MIDTRE LOVENBREEN, and AUSTRE BROEGGERBREEN [255-228]. They are replaced by [2452, 2338, 2326, 2334], which include point-level data.

### Data: Fixed
- Fix or remove incorrect unicode characters (e.g. "†AJUSAISKII" → "AJUSAISKII", "BL≈" → "BLÅ", "Bjˆrnsson" → "Björnsson").

#### `GlaThiDa_ID`
- Change `T.GlaThiDa_ID` from [2004, 2004-2008, 2015] to [2004-2010] to point to correct entries in `TT` and `TTT`.
- Change `GlaThiDa_ID` (`T`, `TT`, `TTT`) for CHARQUINI SUR from [2010] to [2093] to remove duplicate use of [2010].

#### `POLITICAL_UNIT`
- Change `TTT.POLITICAL_UNIT` for MARUKH [2074] from "GE" (Georgia) to "RU" (Russia, correct) to match `T.POLITICAL_UNIT`.
- Change `T.POLITICAL_UNIT` from "SU" (Soviet Union, deprecated) to "RU" (Russia, correct) to match `POLITICAL_UNIT` (`TT`, `TTT`) [173, 176, 180, 183, 192, 339-340, 491].
- Change `T.POLITICAL_UNIT` from "AT" (Austria) to "IT" (Italy) [250].
- Change `POLITICAL_UNIT` (`T`, `TTT`) from "AT" (Austria) to "IT" (Italy) [1966].
- Change `POLITICAL_UNIT` (`T`, `TT`, `TTT`) from "NO" (Norway) to "SJ" (Svalbard and Jan Mayen) [109-167, 194-195, 205, 218, 225-228, 342-345, 359, 423-485, 498, 509-510, 560, 2057-2071, 2075-2076].

#### `GLACIER_NAME`
- Change `TT.GLACIER_NAME` from "SCHLADMINGER" to "SCHLADMINGER GLETSCHER" (more complete) to match `T.GLACIER_NAME` [104].
- Change `TTT.GLACIER_NAME` from "SULDENFERNER" to "SULDENFERNER (SOUTH)" (more complete) to match `T.GLACIER_NAME` [1946].
- Change `TTT.GLACIER_NAME` from "GURGLER" to "GURGLERFERNER" (more complete) to match `T.GLACIER_NAME` [1962].
- Change `TT.GLACIER_NAME` from "URUMQI NO.1" to "URUMQI GLACIER NO.1" (more complete) to match `T.GLACIER_NAME` [2083].
- Change `T.GLACIER_NAME` from "WEISSEEFERNER" to "WEISSSEEFERNER" (correct transliteration of "Weißseeferner") to match `TTT.GLACIER_NAME` [2008].
- Change `T.GLACIER_NAME` from "PLANNEVE" to "PLAN NEVE" (preferred) to match `GLACIER_NAME` (`TT`, `TTT`) [2018].
- Change `GLACIER_NAME` (`T`, `TT`) from "HARDANGERJOKULEN" to "HARDANGERJOEKULEN" (correct transliteration of "Hardangerjøkulen") to match `TTT.GLACIER_NAME` [2068].

#### `SOURCE_ID`
- Change `T.SOURCE_ID` from "WGMS" (invalid value) to "FOG" (correct value) [5, 7-8, 25, 33-34, 38-44, 46-47, 73, 92, 161, 196, 202, 207-208, 210-213, 224, 304, 307, 310-312, 315, 317, 320, 322-323, 325, 329-330, 337, 343, 347-351, 354-356, 358, 363, 505-506, 512-513, 528, 2011, 2086-2089].

#### `GLACIER_ID`
- Change `T.GLACIER_ID` from "726SU4G08005062" (invalid for `T.SOURCE_ID`: "WGI") to "SU4G08005062" [327].

#### `SURVEY_DATE`
- Change `T.SURVEY_DATE` from "99999999" to "19929999" (more complete) to match `TTT.SURVEY_DATE` [33].
- Change `TTT.SURVEY_DATE` from "19769999" to "19760328" (more complete) to match `T.SURVEY_DATE` [319].
- Change `SURVEY_DATE` (`TT`, `TTT`) from "20109999" to "20100216" (more complete) to match `T.SURVEY_DATE` [362].
- Change `TTT.SURVEY_DATE` from "20099999" to "20090799" (more complete) to match `T.SURVEY_DATE` [466].
- Change `SURVEY_DATE` (`TT`, `TTT`) from "20069999" to "20061107" (more complete) to match `T.SURVEY_DATE` [486, 487].
- Change `SURVEY_DATE` (`TT`, `TTT`) from "20109999" to "20100917" (more complete) to match `T.SURVEY_DATE` [488].
- Change `SURVEY_DATE` (`TT`, `TTT`) from "20079999" to "20071003" (more complete) to match `T.SURVEY_DATE` [489].
- Change `SURVEY_DATE` (`TT`, `TTT`) from "20079999" to "20071002" (more complete) to match `T.SURVEY_DATE` [490].
- Change `TTT.SURVEY_DATE` from "20109999" to "20089999" (`TTT.REMARKS` ~ "2008") or "20129999" (`TTT.REMARKS` ~ "2012") and change `T.SURVEY_DATE` from "20129999" to average "2010999" [497].
- Change `TTT.SURVEY_DATE` from "20029999" to "20020599" (`TTT.REMARKS` ~ "HEM data"), "20060799" (`TTT.REMARKS` ~ "GPR data"), or "19359999" (`TTT.REMARKS` ~ "Drilling hole data") (See https://doi.org/10.3189/2012JoG11J098) [499].
- Change `TTT.SURVEY_DATE` from "20029999" to "20020599" (more complete) to match `T.SURVEY_DATE` [500].
- Change `TTT.SURVEY_DATE` from "20079999" to "20070729" (more complete) to match `T.SURVEY_DATE` [554].
- Change `TTT.SURVEY_DATE` of first point from "19989999" to "20039999", and change `T.SURVEY_DATE` from "20039999" to "19989999" since majority of points are from the 1998 survey (https://doi.pangaea.de/10.1594/PANGAEA.849497) [1976].
- Change `T.SURVEY_DATE` from "20029999" to "19999999" (https://doi.pangaea.de/10.1594/PANGAEA.849488) to match `TTT.SURVEY_DATE` [2010].
- Change `TT.SURVEY_DATE` from "20130399" to "20131003" to match `SURVEY_DATE` (`T`, `TTT`) [2018].
- Change `TT.SURVEY_DATE` from "20130399" to "20110399" to match `SURVEY_DATE` (`T`, `TTT`) [2019].
- Change `TTT.SURVEY_DATE` from "20052604", "20052704" (YYYYDDMM) to "20050426", "20050427" (YYYYMMDD) [2057].
- Change `TTT.SURVEY_DATE` from "20060905" (YYYYDDMM) to "20060509" (YYYYMMDD) to match `T.SURVEY_DATE` (see https://www.nve.no/Media/7200/data_istykkelse_nve_v2-0_2018.zip) [2058].
- Change `T.SURVEY_DATE` from "20120809" (YYYYDDMM) to "20120908" (YYYYMMDD) to match `TTT.SURVEY_DATE` (see https://www.nve.no/Media/7200/data_istykkelse_nve_v2-0_2018.zip) [2061].
- Change `TTT.SURVEY_DATE` from "20082105", "20081303" (YYYYDDMM) to "20080521", "20080313" (YYYYMMDD) (see https://www.nve.no/Media/7200/data_istykkelse_nve_v2-0_2018.zip) [2062].
- Change `T.SURVEY_DATE` from "31032014" (DDMMYYYY) to "20040331" (YYYYMMDD) (see https://www.nve.no/Media/7200/data_istykkelse_nve_v2-0_2018.zip) [2065].
- Change `T.SURVEY_DATE` from "22.04.2004 00:00" (MM.DD.YYYY hh:mm) to "20040421" (YYYYMMDD) to match earliest date in `TTT.SURVEY_DATE` (see https://www.nve.no/Media/7200/data_istykkelse_nve_v2-0_2018.zip) [2067].
- Change `T.SURVEY_DATE` from "20100318" to "19860520" to match `TTT.SURVEY_DATE` (see https://www.nve.no/Media/7200/data_istykkelse_nve_v2-0_2018.zip) [2071].
- Change `TTT.SURVEY_DATE` from "20140405" to "20140406" to match `T.SURVEY_DATE` [2075]. NOTE: The correct date may be "20150406", since https://doi.org/10.3189/2015JoG15J141 mentions "5–7 April 2015", although http://svalglac.eu/Inventory_shpArcGIS_layers.zip has "2014".
- Change `T.SURVEY_DATE` from "" to "19869999" to match `TTT.SURVEY_DATE` [2082].
- Change `TTT.SURVEY_DATE` from "2013" (YYYY) to "20139999" (YYYYMMDD) to match `T.SURVEY_DATE` [2085].
- Change `TTT.SURVEY_DATE` from "2009" (YYYY) to "20099999" (YYYYMMDD) to match `T.SURVEY_DATE` [2086].
- Change `TTT.SURVEY_DATE` from "20069999" to "20060899" (more complete) to match `T.SURVEY_DATE` [2087].
- Change `TT.SURVEY_DATE` from "20069999" to "20060899" (more complete) and `TTT.SURVEY_DATE` from "2006" to "20060899" (more complete) to match `T.SURVEY_DATE` [2088, 2089].
- Change `T.SURVEY_DATE` from "20150814" to "20140815" (http://orbit.dtu.dk/files/134812923/aaar0016_049.pdf, "12–17 August 2014") to match `TTT.SURVEY_DATE` [2092].
- Change `SURVEY_DATE` (`T`, `TTT`) from "19969999" to "19959999" (https://doi.pangaea.de/10013/epic.45983.d001, "1995") [1937].

#### `DEM_DATE`
- Change `T.DEM_DATE` from "20100318" to "19860520" to match `TTT.SURVEY_DATE` (see https://www.nve.no/Media/7200/data_istykkelse_nve_v2-0_2018.zip) [2071].
- Change `T.DEM_DATE` from "20109999" to "20069999" (`TTT.REMARKS`: "Year: Date of DEM 2006") [362].
- Change `T.DEM_DATE` from "19979999" to "19959999" (`TTT.REMARKS`: "Year of elevation: 1995;...") [1937].
- Change `T.DEM_DATE` from "99999999" to "" [5-6, 33-49, 91-92, 94-95, 99, 103, 107-165, 194-195, 197-211, 308, 310, 314-316, 325-326, 422, 467-485, 501, 529-553, 2072-2073, 2090].

#### `POINT_ID`
- Assign sequential `TTT.POINT_ID` (1, 2, ...) to points with missing values and append "TTT.POINT_ID assigned in order of submission." to `T.REMARKS`  [2079].
- Append ".1" to the second of sequential duplicate `TTT.POINT_ID` to enforce uniqueness [2057-2058].

#### `T.LAT`, `T.LON` / `TTT.POINT_LAT`, `TTT.POINT_LON`
- Fix point coordinates (`TTT.POINT_LON`, `TTT.POINT_LAT`) for 1937 WEISSBRUNNFERNER by assigning EPSG:32632 (WGS 84 / UTM zone 32N) to the original dataset (https://doi.pangaea.de/10.1594/PANGAEA.849336), then transform to EPSG:4326 (WGS 84).
- Fix `T.LON` for some Russian glaciers by removing negative sign [339-340, 491].
- Fix `T.LON` for AGASSIZ ICE CAP from "0.75" to "-75.0" [211].

#### `SURVEY_METHOD_DETAILS`
- Change `T.SURVEY_METHOD_DETAILS` from "SURVEY_METHOD_DETAILS" to "Narod GPR, 6.5MHz, wave velocity 0.168m/ns" (based on similar surveys and `TTT.REMARKS`) [1934].

#### `INTERPOLATION_METHOD`
- Change `T.INTERPOLATION_METHOD` from "TIN" (invalid value) to "TRI" [2045-2055].

#### `NUMBER_OF_SURVEY_POINTS`
- Fill empty `T.NUMBER_OF_SURVEY_POINTS` with the number of points in `TTT` [33, 466, 499-502, 2027-2033, 2082].

#### `INVESTIGATOR`
- Change `T.INVESTIGATOR` from "Glenn FLOWERS" to "Gwenn FLOWERS" [2078-2079].

#### `DATA_FLAG`
- Change `T.DATA_FLAG` from "Error in logging profiles, thus only point data" (invalid value) to "" and append instead to `T.REMARKS` [2057, 2058].
- Change `TTT.DATA_FLAG` from "2" (invalid value) to "" [2012].

#### `REMARKS`
- Replace field codes with field names ("FieldT9" → "T.DEM_DATE", "TTT8" → "TTT.ELEVATION") in `T.REMARKS` [2091].
- Change `REMARKS` (`TT`, `TTT`) to "" when equal for all points and included elsewhere [362, 500, 2011-2012, 2073, 2085-2086, 2091-2092, 2093: previously 2010 CHARQUINI SUR].
- Append `TTT.REMARKS` to `T.REMARKS` and change to "" when equal for all points and not included in `T.REMARKS` [33, 502, 554, 1938-1946, 2013-2025, 2061, 2075-2076, 2078, 2080].
- Change `TTT.REMARKS` to "" and append the following to `T.REMARKS`:
  - [499] "TTT.SURVEY_DATE: 19359999 Drilling hole data from Finn et al., (2012). Jour. Glac. Based on Fowler, C.S., (1936). Msc Thesis. Survey in 1930s, but specific year unknown. // TTT.SURVEY_DATE: 20020599 HEM data from Finn et al., (2012). Jour. Glac. // TTT.SURVEY_DATE: 20060799 GPR data from Finn et al., (2012). Jour. Glac. based on Tulaczyk, S., (2006). Pers. Comm."
  - [501] "GPR data from Finn et al., (2012). Jour. Glac. based on Tucker et al., (2009). Geol. Soc. US."
  - [2057] "Thickness includes winter snow 2005 (See Glac. Inv. Norway 2005, NVE Report 2-2006, p. 53)"
  - [2058] "Elevation from same day GNSS survey. Thickness includes winter snow 2006 (See Glac. Inv. Norway 2006, NVE Report 1-2007)"
  - [2059, 2060] "Elevation from same day GNSS survey. Thickness includes winter snow 2011 (Data: NVE)"
  - [2062] "Thickness includes winter snow 2008 (See Glac. Inv. Norway 2008, NVE Report 2-2009, p. 71)"
- Change `TTT.REMARKS` to "" and append the following to `T.SURVEY_METHOD_DETAILS`:
  - [1947-2010] "antenna length 15/25m. Narod and Clarke (1994)"
  - [1933-1937] "Narod and Clarke (2014)"

## 2.1.0 (2016-10-27)

### Structure: Changed
- Remame `T_2016.csv`, `TT_2016.csv`, and `TTT_2016.csv` to `T_2016_corr.csv`, `TT_2016_corr.csv`, and `TTT_2016_corr.csv`, respectively.
- Add description of changes to `WGMS_glathida_2016.txt`.

### Data: Fixed
- Switch values in `TTT.POINT_LAT` and `TTT.POINT_LON` for some glaciers in Norway, Chile, China, and Switzerland [497, 2027-2033, 2057-2065, 2067-2071, 2085, 2091].
- Change `TTT.SURVEY_DATE` from "4739999" to "20079999" to more closely match `T.SURVEY_DATE` ("20070729") [554].
- Change `TTT.ELEVATION` from "#REF!" to "259" for `TTT.POINT_ID`: 9288 [2071].

### Data: Removed
- Point (`TTT`) with outlier `TTT.POINT_LON` (`TTT.POINT_ID`: 1) [2083]. `TTT.POINT_ID` of the remaining points were shifted down by 1 (e.g. from "2" to "1", from "3" to "2").

## 2.0.0 (2016-07-04)

### Structure: Added
- Add `T.DEM_DATE` (YYYYMMDD) for the date of the elevation data used for surface elevation fields (e.g. `TT.LOWER_BOUND`, `TTT.ELEVATION`) and backfill the field for some existing surveys [1-3, 220, 319, 321, 329, 333, 336-337, 342, 348, 359, 362, 364, 423-427, 429, 431, 433, 435, 437-438, 440, 442, 444, 466, 486-490, 497-500, 505-506, 511, 514, 516, 528, 554, 560].
- Add `T.SURVEY_METHOD_DETAILS` for details of the survey method which can be used to assess the uncertainty of the ice thickness measurements.
- Add `DATA_FLAG` (`T`, `TT`, `TTT`) to flag ice thickness data known to be erroneous or limited to glacier parts (`T` and `TT` only).
- Add "FOG" (Fluctuations of Glaciers) and "GLIMS" (Global Land Ice Measurements from Space) to the list of values allowed in `T.SOURCE_ID`.

### Structure: Changed
- Rename `WGMS_glathida_2014.txt` to `WGMS_glathida_2016.txt` and update for the new release.
- Rename `GlaThiDa_documentation.pdf` to `GlaThiDa_2016_documentation.pdf` and update for the new release.
- Remame `T.csv`, `TT.csv`, and `TTT.csv` to `T_2016.csv`, `TT_2016.csv`, and `TTT_2016.csv`, respectively.
- Switch from using ";" (semicolon) to "," (comma) as the delimiter in `T`, `TT`, and `TTT`.
- Rename `ID` to `GLACIER_ID`.
- Rename `ACCURACY_MEAN_THICKNESS` to `MEAN_THICKNESS_UNCERTAINTY` (`T`, `TT`).
- Rename `ACCURACY_MAX_THICKNESS` to `MAX_THICKNESS_UNCERTAINTY` (`T`, `TT`).
- Rename `TTT.ACCURACY_THICKNESS` to `TTT.THICKNESS_UNCERTAINTY`.
- Rename `YEAR` (`TT`, `TTT`) to `SURVEY_DATE` to match `T.SURVEY_DATE`.
- Change "RGI3.2" (Randolph Glacier Inventory, version 3.2) to "RGI" (Randolph Glacier Inventory) in the list of values allowed in `T.SOURCE_ID`, since the RGI version is part of any RGI glacier identifier.
- Change the limit on `T.LAT`, `T.LON` from 7 digits to 6 decimal places.
- Change the limit on `AREA` (`T`, `TT`) from 6 digits to 5 decimal places.
- Change the limit on `T.TOTAL_LENGTH_OF_SURVEY_PROFILES` from 4 digits to 2 decimal places.
- Change the limit on `TTT.POINT_LAT`, `TTT.POINT_LON` from 10 digits to 7 decimal places.
- Extend the limit on `TTT.THICKNESS` from 4 to 6 digits.

### Structure: Removed
- The 1 047 076 empty rows at the end of `T`.
- The 10 empty rows at the end of `TT`.
- The 1 empty column at the end of `TT`.
- The 48 empty columns at the end of `TTT`.
- Header lines in `T` containing a table label ("T GLACIER THICKNESS OVERVIEW...") and field codes ("T1;T2;...").
- Field `T.YEAR` (YYYY of survey), which was redundant given the presence of `T.SURVEY_DATE` (YYYYMMDD of survey).

### Data: Added
- Surveys (`T`, `TTT`) of glaciers in South Tyrol, Italy submitted by Kay Helfricht [1933-1946] (https://doi.org/10.1594/PANGAEA.849390). `T.INVESTIGATOR` lists Andrea Fischer, Christian Mitterer, Bernd Seiser, Martin Stocker-Waldhuber, Lea Hartl, Jakob Abermann, Gerhard Markl, Daniel Binder, and Stefan Scheiblauer.
- Surveys (`T`, `TTT`) of glaciers in Austria submitted by Kay Helfricht [1947-2008 (including two 2004), 2015 VERNAGTFERNER] (https://doi.org/10.1594/PANGAEA.849497). `T.INVESTIGATOR` lists Andrea Fischer.
- Surveys (`T`, `TT`, `TTT`) of glaciers in Bolivia and Colombia submitted by Antoine Rabatel [2010-2012]. `T.INVESTIGATOR` for LA CONEJERAS [2011] also lists Jorge Luis Ceballos, Michael Zemp, and Felipe Echeverry.
- Surveys (`T`, `TT`, `TTT`) of glaciers in Switzerland submitted by Matthias Huss [2013-2014, 2015 GURSCHEN, 2016-2026]. `T.INVESTIGATOR` also lists Mauro Fischer.
- Surveys (`T`, `TTT`) of glaciers in Chile submitted by Marius Schaefer [2027-2055]. `T.INVESTIGATOR` lists Gino Casassa, Norbert Blindow, José Luis Rodríguez Lagos, Andrés Rivera, and Rodrigo Zamora.
- Surveys (`T`,  `TTT`) of glaciers in Norway submitted by Liss Marie Andreassen [2057-2071]. `T.INVESTIGATOR` also lists Hallgeir Elvehøy, Kjetil Melvold, Ingvild Sørdal, Erlend Førre, Jostein Bakke, Michael Kennett, Bjarne Kjøllmoen, Rune Engeset, Tron Laumann, and Arne Chr. Sætrang.
- Surveys (`T`, `TT`, `TTT`) of glaciers in Russia submitted by Stanislav Kutuzov [2072-2074]. `T.INVESTIGATOR` lists Ivan Lavrentiev.
- Surveys (`T`, `TTT`) of glaciers in Svalbard submitted by Francisco Navarro [2075-2076].
- Surveys (`T`, `TTT`) of glaciers in New Zealand, Canada, Antarctica, and China compiled and submitted by Daniel Farinotti [2077-2084]. `T.INVESTIGATOR` and submission notes also list Gwenn E. Flowers (misspelled "Glenn Flowers"), Huilin Li, and John Sanders as contributors, Brian Anderson as compiler, and Robert W. Jacobel, Ian Owens, Nat J. Wilson, and Laurent Mingo as investigators.
- Surveys (`T`, `TT`, `TTT`) of glaciers in China submitted by Huilin Li [2085-2089].
- Survey (`T`, `TTT`) of Sary Tor, Kyrgyzstan submitted by Ivan Lavrentiev [2090].
- Survey (`T`, `TTT`) of Tiefengletscher, Switzerland by Andri Moll and Horst Machguth [2091].
- Survey (`T`, `TTT`) of Aqqutikitsoq, Greenland by Elisa Bjerre and Peter Alexander Stentoft [2092].

### Data: Removed
- Surveys (`T`) of glaciers in Austria and Italy [239-249, 251-303]. They are replaced by [1943, 1947-1959, 1961-2008 (including two 2004), 2015 VERNAGTFERNER], which include point-level data.

### Data: Fixed
- Change `T.POLITICAL_UNIT` from "SU" (Soviet Union, deprecated) to "RU" (Russia) [35-38, 47, 67, 168-172, 174-175, 177-179, 181-182, 184-191, 193, 197-198, 327, 346, 366-405, 407-496]
- Change `T.POLITICAL_UNIT` from "SU" (Soviet Union, deprecated) to "KG" (Kyrgyzstan) [39-41, 43, 46].
- Change `T.POLITICAL_UNIT` from "SU" (Soviet Union, deprecated) to "CN" (China) [42, 406].
- Change `T.POLITICAL_UNIT` from "SU" (Soviet Union, deprecated) to "KZ" (Kazakhstan) [44, 48-66, 68-92, 505-506].
- Change `T.POLITICAL_UNIT` from "SU" (Soviet Union, deprecated) to "GE" (Georgia) [326].
- Change `T.POLITICAL_UNIT` from "SU" (Soviet Union, deprecated) to "TJ" (Tajikistan) [45].
- Append "POLITICAL_UNIT updated by spatial query with data from gadm.org." to `T.REMARKS` [45, 48-91, 326-327, 346, 366-421].
- Replace special characters in `T.GLACIER_NAME` by the transliteration rules in `GlaThiDa_2016_documentation.pdf` [113-115, 119, 127, 130, 133-134, 139, 143, 148, 156, 160, 163, 228, 427-428, 437, 467, 473, 477-478, 511].
- Add missing "FERNER" suffix to `T.GLACIER_NAME` [96, 101].
- Change `T.GLACIER_NAME` from "GRINNER FERNER" to "GRINNERFERNER" (no space) [238].
- Change `T.GLACIER_NAME` from "DAOGELFERNER" (misspelling) to "DAUNKOGELFERNER" [308].
- Change `T.GLACIER_NAME` from "GLACIER URUMQI NO. #" to "URUMQI GLACIER NO. #" [529-533].
- Update `T.LAT`, `T.LON` with higher precision and/or more accurate coordinates [40, 93, 95-96, 98, 105-106, 311, 313-314, 317, 331, 343-346, 357, 433-434, 515-518, 524, 527].
- Round `TTT.ELEVATION` from 1 to 0 decimal places as required by `GlaThiDa_2016_documentation.pdf` [33, 319, 362, 466, 486-490, 497, 499-502, 554].
- Round `TTT.THICKNESS` from 2 to 0 decimal places as required by `GlaThiDa_2016_documentation.pdf` [33, 319, 362, 466, 486-490, 497, 499-502, 554].
- Round `TTT.THICKNESS_UNCERTAINTY` from 1 or 2 to 0 decimal places as required by `GlaThiDa_2016_documentation.pdf` [33, 319, 362, 466, 486-490, 497, 499-502, 554].
- Round `TTT.POINT_LAT`, `TTT.POINT_LON` from 8 to 7 decimal places as required by `GlaThiDa_2016_documentation.pdf` [362, 466, 497, 554].
- Switch values in `TTT.POINT_LAT` and `TTT.POINT_LON` [497].

## 1.0.0 (2014-09-25)

The initial release is described in detail in the following journal article:

> Isabelle Gärtner-Roer, Kathrin Naegeli, Matthias Huss, Thomas Knecht, Horst Machguth, Michael Zemp (2014): A database of worldwide glacier thickness observations. Global and Planetary Change. DOI:[10.1016/j.gloplacha.2014.09.003](http://dx.doi.org/10.1016/j.gloplacha.2014.09.003)
