create or replace view aggJoin1740079053898460288 as (
with aggView6635384057034076290 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView6635384057034076290 where mi.info_type_id=aggView6635384057034076290.v21);
create or replace view aggView8834912325770257870 as select v29, v22 from aggJoin1740079053898460288 group by v29,v22;
create or replace view aggJoin4498673422069766041 as (
with aggView4422991111287156707 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView4422991111287156707 where mc.company_id=aggView4422991111287156707.v1);
create or replace view aggJoin5056648752091400331 as (
with aggView3351388810558054393 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin4498673422069766041 join aggView3351388810558054393 using(v8));
create or replace view aggJoin6056908095510898472 as (
with aggView8617899150301495813 as (select v29 from aggJoin5056648752091400331 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView8617899150301495813 where t.id=aggView8617899150301495813.v29 and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')));
create or replace view aggJoin304958178148286532 as (
with aggView2653772021292149462 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select movie_id as v29 from movie_info_idx as mi_idx, aggView2653772021292149462 where mi_idx.info_type_id=aggView2653772021292149462.v26);
create or replace view aggJoin2671330799422718467 as (
with aggView8296418183328519093 as (select v29 from aggJoin304958178148286532 group by v29)
select v29, v30, v33 from aggJoin6056908095510898472 join aggView8296418183328519093 using(v29));
create or replace view aggView8347476809492442451 as select v29, v30 from aggJoin2671330799422718467 group by v29,v30;
create or replace view aggJoin129639316363521972 as (
with aggView2650756639866251096 as (select v29, MIN(v30) as v42 from aggView8347476809492442451 group by v29)
select v22, v42 from aggView8834912325770257870 join aggView2650756639866251096 using(v29));
select MIN(v22) as v41,MIN(v42) as v42 from aggJoin129639316363521972;
