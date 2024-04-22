create or replace view aggView6474738083846991279 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin156380476760753788 as (
with aggView6990167265997741606 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView6990167265997741606 where mi_idx.info_type_id=aggView6990167265997741606.v12 and info<'7.0');
create or replace view aggJoin6213610149360200983 as (
with aggView4091666708185828210 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView4091666708185828210 where t.kind_id=aggView4091666708185828210.v17 and production_year>2009);
create or replace view aggView8930348429921952045 as select v38, v37 from aggJoin6213610149360200983 group by v38,v37;
create or replace view aggJoin4658124320691332046 as (
with aggView993014645306900879 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView993014645306900879 where mk.keyword_id=aggView993014645306900879.v14);
create or replace view aggJoin6706560720530930428 as (
with aggView6140643018124632530 as (select v37 from aggJoin4658124320691332046 group by v37)
select v37, v32 from aggJoin156380476760753788 join aggView6140643018124632530 using(v37));
create or replace view aggView713342064361857820 as select v37, v32 from aggJoin6706560720530930428 group by v37,v32;
create or replace view aggJoin68072962967426506 as (
with aggView6306679093595704976 as (select v37, MIN(v38) as v51 from aggView8930348429921952045 group by v37)
select v37, v32, v51 from aggView713342064361857820 join aggView6306679093595704976 using(v37));
create or replace view aggJoin4101463693021642571 as (
with aggView7638475118938670419 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin68072962967426506 group by v37,v51)
select movie_id as v37, company_id as v1, company_type_id as v8, note as v23, v51, v50 from movie_companies as mc, aggView7638475118938670419 where mc.movie_id=aggView7638475118938670419.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3035184462959882336 as (
with aggView7295063302019901173 as (select id as v8 from company_type as ct)
select v37, v1, v23, v51, v50 from aggJoin4101463693021642571 join aggView7295063302019901173 using(v8));
create or replace view aggJoin3171996381047088787 as (
with aggView4542852884749988923 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView4542852884749988923 where mi.info_type_id=aggView4542852884749988923.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin726954576049382357 as (
with aggView4890801057628234688 as (select v37 from aggJoin3171996381047088787 group by v37)
select v1, v23, v51 as v51, v50 as v50 from aggJoin3035184462959882336 join aggView4890801057628234688 using(v37));
create or replace view aggJoin8525273130899047499 as (
with aggView6723145274863439661 as (select v1, MIN(v51) as v51, MIN(v50) as v50 from aggJoin726954576049382357 group by v1,v50,v51)
select v2, v51, v50 from aggView6474738083846991279 join aggView6723145274863439661 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin8525273130899047499;
