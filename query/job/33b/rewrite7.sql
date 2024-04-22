create or replace view aggJoin8454308898797385640 as (
with aggView484078500000091996 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[nl]')
select movie_id as v49, v73 from movie_companies as mc1, aggView484078500000091996 where mc1.company_id=aggView484078500000091996.v1);
create or replace view aggJoin7512479293350731994 as (
with aggView816703783949576915 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView816703783949576915 where mc2.company_id=aggView816703783949576915.v8);
create or replace view aggJoin6948355053445867515 as (
with aggView30142514952513594 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView30142514952513594 where mi_idx1.info_type_id=aggView30142514952513594.v15);
create or replace view aggJoin4707242321582233128 as (
with aggView3484099465798240131 as (select v49, MIN(v38) as v75 from aggJoin6948355053445867515 group by v49)
select v49, v73 as v73, v75 from aggJoin8454308898797385640 join aggView3484099465798240131 using(v49));
create or replace view aggJoin3309751737404721115 as (
with aggView6785893873493796568 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView6785893873493796568 where ml.link_type_id=aggView6785893873493796568.v23);
create or replace view aggJoin7154711571588410617 as (
with aggView2554415771059878330 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView2554415771059878330 where mi_idx2.info_type_id=aggView2554415771059878330.v17 and info<'3.0');
create or replace view aggJoin6019758447771417919 as (
with aggView8721113808041097395 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView8721113808041097395 where t1.kind_id=aggView8721113808041097395.v19);
create or replace view aggJoin5564783479441565202 as (
with aggView8505318147803303122 as (select v49, MIN(v50) as v77 from aggJoin6019758447771417919 group by v49)
select v49, v73 as v73, v75 as v75, v77 from aggJoin4707242321582233128 join aggView8505318147803303122 using(v49));
create or replace view aggJoin4125515293503024229 as (
with aggView6224146180130567231 as (select v49, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77 from aggJoin5564783479441565202 group by v49,v73,v75,v77)
select v61, v73, v75, v77 from aggJoin3309751737404721115 join aggView6224146180130567231 using(v49));
create or replace view aggJoin7777410586533687646 as (
with aggView3357474489223410123 as (select v61, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77 from aggJoin4125515293503024229 group by v61,v73,v75,v77)
select v61, v43, v73, v75, v77 from aggJoin7154711571588410617 join aggView3357474489223410123 using(v61));
create or replace view aggJoin2190678995970974788 as (
with aggView9193261200655542273 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView9193261200655542273 where t2.kind_id=aggView9193261200655542273.v21 and production_year= 2007);
create or replace view aggJoin1420332658135741701 as (
with aggView1881544294770112069 as (select v61, MIN(v62) as v78 from aggJoin2190678995970974788 group by v61)
select v61, v43, v73 as v73, v75 as v75, v77 as v77, v78 from aggJoin7777410586533687646 join aggView1881544294770112069 using(v61));
create or replace view aggJoin3537627270092853844 as (
with aggView6165064680683814841 as (select v61, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77, MIN(v78) as v78, MIN(v43) as v76 from aggJoin1420332658135741701 group by v61,v73,v78,v75,v77)
select v74 as v74, v73, v75, v77, v78, v76 from aggJoin7512479293350731994 join aggView6165064680683814841 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin3537627270092853844;
