create or replace view aggView8216514452242869023 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin1187861112631357416 as (
with aggView952280329008272089 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView952280329008272089 where mi.info_type_id=aggView952280329008272089.v12);
create or replace view aggJoin2291642558690916222 as (
with aggView1596139988369343674 as (select v22 from aggJoin1187861112631357416 group by v22)
select id as v22, title as v32, kind_id as v14 from title as t, aggView1596139988369343674 where t.id=aggView1596139988369343674.v22 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggJoin284399767314900099 as (
with aggView8544876541069485039 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView8544876541069485039 where miidx.info_type_id=aggView8544876541069485039.v10);
create or replace view aggView5362861064215847601 as select v22, v29 from aggJoin284399767314900099 group by v22,v29;
create or replace view aggJoin3940278780636036592 as (
with aggView4520867801451620847 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32 from aggJoin2291642558690916222 join aggView4520867801451620847 using(v14));
create or replace view aggView4732502762179876539 as select v22, v32 from aggJoin3940278780636036592 group by v22,v32;
create or replace view aggJoin2060794615994336717 as (
with aggView5039645748066771543 as (select v1, MIN(v2) as v43 from aggView8216514452242869023 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView5039645748066771543 where mc.company_id=aggView5039645748066771543.v1);
create or replace view aggJoin4818847140236183797 as (
with aggView638513575191989166 as (select v22, MIN(v32) as v45 from aggView4732502762179876539 group by v22)
select v22, v29, v45 from aggView5362861064215847601 join aggView638513575191989166 using(v22));
create or replace view aggJoin4896319470499017275 as (
with aggView7630644349518811443 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin2060794615994336717 join aggView7630644349518811443 using(v8));
create or replace view aggJoin6159605006581584004 as (
with aggView5709960307075946110 as (select v22, MIN(v43) as v43 from aggJoin4896319470499017275 group by v22,v43)
select v29, v45 as v45, v43 from aggJoin4818847140236183797 join aggView5709960307075946110 using(v22));
select MIN(v43) as v43,MIN(v29) as v44,MIN(v45) as v45 from aggJoin6159605006581584004;
