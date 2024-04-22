create or replace view aggJoin1362928938435452860 as (
with aggView6281732202143819640 as (select id as v24, name as v50 from name as n where gender= 'm' and name_pcode_cf LIKE 'D%')
select person_id as v24, name as v3, v50 from aka_name as an, aggView6281732202143819640 where an.person_id=aggView6281732202143819640.v24 and name LIKE '%a%');
create or replace view aggJoin7195628160720528861 as (
with aggView2410503302398327094 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView2410503302398327094 where pi.info_type_id=aggView2410503302398327094.v16 and note= 'Volker Boehm');
create or replace view aggJoin3323030216558223897 as (
with aggView179101115299093609 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView179101115299093609 where ml.link_type_id=aggView179101115299093609.v18);
create or replace view aggJoin1251846874800616047 as (
with aggView3067880735378706032 as (select v38 from aggJoin3323030216558223897 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView3067880735378706032 where t.id=aggView3067880735378706032.v38 and production_year<=1984 and production_year>=1980);
create or replace view aggJoin8869675080061782695 as (
with aggView681604466980646122 as (select v38, MIN(v39) as v51 from aggJoin1251846874800616047 group by v38)
select person_id as v24, v51 from cast_info as ci, aggView681604466980646122 where ci.movie_id=aggView681604466980646122.v38);
create or replace view aggJoin6023460329022522031 as (
with aggView5018962715135863703 as (select v24 from aggJoin7195628160720528861 group by v24)
select v24, v3, v50 as v50 from aggJoin1362928938435452860 join aggView5018962715135863703 using(v24));
create or replace view aggJoin6171032171298931850 as (
with aggView6767800868656936034 as (select v24, MIN(v50) as v50 from aggJoin6023460329022522031 group by v24,v50)
select v51 as v51, v50 from aggJoin8869675080061782695 join aggView6767800868656936034 using(v24));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin6171032171298931850;
