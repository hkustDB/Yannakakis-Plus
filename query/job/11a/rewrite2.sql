create or replace view aggView898145656468725083 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin5285248894604161880 as (
with aggView3764790567867366081 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView3764790567867366081 where mk.keyword_id=aggView3764790567867366081.v22);
create or replace view aggJoin5426199751740508730 as (
with aggView3422300476928492190 as (select v24 from aggJoin5285248894604161880 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView3422300476928492190 where t.id=aggView3422300476928492190.v24 and production_year<=2000 and production_year>=1950);
create or replace view aggView8259754177549338476 as select v28, v24 from aggJoin5426199751740508730 group by v28,v24;
create or replace view aggJoin8944008830698521928 as (
with aggView645648987643153679 as (select v17, MIN(v2) as v39 from aggView898145656468725083 group by v17)
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView645648987643153679 where mc.company_id=aggView645648987643153679.v17);
create or replace view aggJoin3116784251787571805 as (
with aggView8008040405032942198 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin8944008830698521928 join aggView8008040405032942198 using(v18));
create or replace view aggJoin8911263625751278555 as (
with aggView6971503198323991337 as (select v24, MIN(v39) as v39 from aggJoin3116784251787571805 group by v24,v39)
select v28, v24, v39 from aggView8259754177549338476 join aggView6971503198323991337 using(v24));
create or replace view aggJoin6274073450469084144 as (
with aggView2919209238498593439 as (select v24, MIN(v39) as v39, MIN(v28) as v41 from aggJoin8911263625751278555 group by v24,v39)
select link_type_id as v13, v39, v41 from movie_link as ml, aggView2919209238498593439 where ml.movie_id=aggView2919209238498593439.v24);
create or replace view aggJoin7179552854377947377 as (
with aggView7018104519194248463 as (select v13, MIN(v39) as v39, MIN(v41) as v41 from aggJoin6274073450469084144 group by v13,v39,v41)
select link as v14, v39, v41 from link_type as lt, aggView7018104519194248463 where lt.id=aggView7018104519194248463.v13 and link LIKE '%follow%');
select MIN(v39) as v39,MIN(v14) as v40,MIN(v41) as v41 from aggJoin7179552854377947377;
