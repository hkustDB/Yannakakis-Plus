create or replace view aggJoin632504568496020367 as (
with aggView6750243881073929650 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView6750243881073929650 where mc.company_type_id=aggView6750243881073929650.v8);
create or replace view aggJoin60152616548525360 as (
with aggView524204761621153415 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView524204761621153415 where miidx.info_type_id=aggView524204761621153415.v10);
create or replace view aggJoin4273752829719640602 as (
with aggView88603912677348927 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView88603912677348927 where mi.info_type_id=aggView88603912677348927.v12);
create or replace view aggJoin9155027142097172659 as (
with aggView2311128228447938541 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin632504568496020367 join aggView2311128228447938541 using(v1));
create or replace view aggJoin3673611078376701347 as (
with aggView7730774697475913666 as (select v22 from aggJoin9155027142097172659 group by v22)
select id as v22, title as v32, kind_id as v14 from title as t, aggView7730774697475913666 where t.id=aggView7730774697475913666.v22);
create or replace view aggJoin5416772532781634650 as (
with aggView3289654027006294285 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32 from aggJoin3673611078376701347 join aggView3289654027006294285 using(v14));
create or replace view aggJoin5365529684270756866 as (
with aggView4492736963111297655 as (select v22, MIN(v32) as v45 from aggJoin5416772532781634650 group by v22)
select v22, v29, v45 from aggJoin60152616548525360 join aggView4492736963111297655 using(v22));
create or replace view aggJoin893471481098086772 as (
with aggView8911590320681229795 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin5365529684270756866 group by v22,v45)
select v24, v45, v44 from aggJoin4273752829719640602 join aggView8911590320681229795 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin893471481098086772;
