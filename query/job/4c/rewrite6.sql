create or replace view aggView3812787831342708058 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin9034897471775356932 as select movie_id as v14 from movie_keyword as mk, aggView3812787831342708058 where mk.keyword_id=aggView3812787831342708058.v3;
create or replace view aggView1635626595405003975 as select v14 from aggJoin9034897471775356932 group by v14;
create or replace view aggJoin3016480779405919462 as select id as v14, title as v15 from title as t, aggView1635626595405003975 where t.id=aggView1635626595405003975.v14 and production_year>1990;
create or replace view aggView4261237000794458601 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5212600038615503573 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView4261237000794458601 where mi_idx.info_type_id=aggView4261237000794458601.v1 and info>'2.0';
create or replace view aggView4267743759341610399 as select v14, MIN(v9) as v26 from aggJoin5212600038615503573 group by v14;
create or replace view aggJoin3841347138836434996 as select v15, v26 from aggJoin3016480779405919462 join aggView4267743759341610399 using(v14);
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin3841347138836434996;
