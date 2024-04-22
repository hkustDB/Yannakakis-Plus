create or replace view aggView2106932976072228242 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin4022817033264843862 as (
with aggView1162184760162451361 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView1162184760162451361 where mk.keyword_id=aggView1162184760162451361.v35);
create or replace view aggJoin4395757661558432678 as (
with aggView940309171500452944 as (select v37 from aggJoin4022817033264843862 group by v37)
select movie_id as v37, info as v31 from movie_info as mi, aggView940309171500452944 where mi.movie_id=aggView940309171500452944.v37 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin1003177866931459741 as (
with aggView3929024402455171 as (select v37 from aggJoin4395757661558432678 group by v37)
select id as v37, title as v41, production_year as v44 from title as t, aggView3929024402455171 where t.id=aggView3929024402455171.v37 and production_year= 1998);
create or replace view aggView8631534650935358262 as select v37, v41 from aggJoin1003177866931459741 group by v37,v41;
create or replace view aggJoin6345215647101831641 as (
with aggView59615468571300140 as (select v25, MIN(v10) as v52 from aggView2106932976072228242 group by v25)
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView59615468571300140 where mc.company_id=aggView59615468571300140.v25);
create or replace view aggJoin3214274024141775747 as (
with aggView3496376239173518695 as (select v37, MIN(v41) as v54 from aggView8631534650935358262 group by v37)
select v37, v26, v52 as v52, v54 from aggJoin6345215647101831641 join aggView3496376239173518695 using(v37));
create or replace view aggJoin7651443568367276072 as (
with aggView8197390977172440033 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView8197390977172440033 where cc.subject_id=aggView8197390977172440033.v5);
create or replace view aggJoin1782196386692135629 as (
with aggView7338137985012359166 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin7651443568367276072 join aggView7338137985012359166 using(v7));
create or replace view aggJoin6987238349728761606 as (
with aggView4364333150260379212 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52, v54 from aggJoin3214274024141775747 join aggView4364333150260379212 using(v26));
create or replace view aggJoin4696194953705777871 as (
with aggView1619617759307222854 as (select v37 from aggJoin1782196386692135629 group by v37)
select v37, v52 as v52, v54 as v54 from aggJoin6987238349728761606 join aggView1619617759307222854 using(v37));
create or replace view aggJoin650601174368623399 as (
with aggView8995682069343608513 as (select v37, MIN(v52) as v52, MIN(v54) as v54 from aggJoin4696194953705777871 group by v37,v52,v54)
select link_type_id as v21, v52, v54 from movie_link as ml, aggView8995682069343608513 where ml.movie_id=aggView8995682069343608513.v37);
create or replace view aggJoin3317957113387085044 as (
with aggView5940781987085569320 as (select v21, MIN(v52) as v52, MIN(v54) as v54 from aggJoin650601174368623399 group by v21,v52,v54)
select link as v22, v52, v54 from link_type as lt, aggView5940781987085569320 where lt.id=aggView5940781987085569320.v21 and link LIKE '%follow%');
select MIN(v52) as v52,MIN(v22) as v53,MIN(v54) as v54 from aggJoin3317957113387085044;
