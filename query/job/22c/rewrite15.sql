create or replace view aggJoin826419496320609608 as (
with aggView1075636313786908866 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView1075636313786908866 where mc.company_id=aggView1075636313786908866.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4982328388887964264 as (
with aggView5987852363146244360 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin826419496320609608 join aggView5987852363146244360 using(v8));
create or replace view aggJoin5549787779189247923 as (
with aggView5595279691966878044 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView5595279691966878044 where t.kind_id=aggView5595279691966878044.v17 and production_year>2005);
create or replace view aggJoin846707448750314860 as (
with aggView6002079744782283507 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView6002079744782283507 where mi_idx.info_type_id=aggView6002079744782283507.v12 and info<'8.5');
create or replace view aggJoin8279328829416009191 as (
with aggView5179342380828800605 as (select v37, MIN(v32) as v50 from aggJoin846707448750314860 group by v37)
select v37, v23, v49 as v49, v50 from aggJoin4982328388887964264 join aggView5179342380828800605 using(v37));
create or replace view aggJoin288787017997973336 as (
with aggView8367675304062926763 as (select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin8279328829416009191 group by v37,v49,v50)
select movie_id as v37, info_type_id as v10, info as v27, v49, v50 from movie_info as mi, aggView8367675304062926763 where mi.movie_id=aggView8367675304062926763.v37 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin3863373466299625084 as (
with aggView902991464457609239 as (select id as v10 from info_type as it1 where info= 'countries')
select v37, v27, v49, v50 from aggJoin288787017997973336 join aggView902991464457609239 using(v10));
create or replace view aggJoin5627472924174709364 as (
with aggView836682225138600219 as (select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin3863373466299625084 group by v37,v49,v50)
select v37, v38, v41, v49, v50 from aggJoin5549787779189247923 join aggView836682225138600219 using(v37));
create or replace view aggJoin6719377985398216557 as (
with aggView116244102891353357 as (select v37, MIN(v49) as v49, MIN(v50) as v50, MIN(v38) as v51 from aggJoin5627472924174709364 group by v37,v49,v50)
select keyword_id as v14, v49, v50, v51 from movie_keyword as mk, aggView116244102891353357 where mk.movie_id=aggView116244102891353357.v37);
create or replace view aggJoin7205441201935262602 as (
with aggView4375178354863004953 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v49, v50, v51 from aggJoin6719377985398216557 join aggView4375178354863004953 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin7205441201935262602;
