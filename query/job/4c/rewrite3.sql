create or replace view aggJoin692998788019132106 as (
with aggView6408757591979783925 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView6408757591979783925 where mi_idx.info_type_id=aggView6408757591979783925.v1);
create or replace view aggJoin6202489512767955213 as (
with aggView7058018989124733389 as (select v9, v14 from aggJoin692998788019132106 group by v9,v14)
select v14, v9 from aggView7058018989124733389 where v9>'2.0');
create or replace view aggJoin7398577324485685484 as (
with aggView3456299044663550762 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView3456299044663550762 where mk.keyword_id=aggView3456299044663550762.v3);
create or replace view aggJoin6968147804478764990 as (
with aggView7560505001180765572 as (select v14 from aggJoin7398577324485685484 group by v14)
select id as v14, title as v15, production_year as v18 from title as t, aggView7560505001180765572 where t.id=aggView7560505001180765572.v14 and production_year>1990);
create or replace view aggView1112621944649409282 as select v14, v15 from aggJoin6968147804478764990 group by v14,v15;
create or replace view aggJoin8893533583381662179 as (
with aggView1124315460778811302 as (select v14, MIN(v9) as v26 from aggJoin6202489512767955213 group by v14)
select v15, v26 from aggView1112621944649409282 join aggView1124315460778811302 using(v14));
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin8893533583381662179;
