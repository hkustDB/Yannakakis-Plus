create or replace view aggView5108171806428703945 as select id as v12, title as v31 from title as t;
create or replace view aggJoin4399828023619652707 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView5108171806428703945 where mk.movie_id=aggView5108171806428703945.v12;
create or replace view aggView3184121218028258479 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3760176591142334759 as select v12, v31 from aggJoin4399828023619652707 join aggView3184121218028258479 using(v18);
create or replace view aggView7047957519056747957 as select v12, MIN(v31) as v31 from aggJoin3760176591142334759 group by v12;
create or replace view aggJoin3540627052163280759 as select company_id as v1, v31 from movie_companies as mc, aggView7047957519056747957 where mc.movie_id=aggView7047957519056747957.v12;
create or replace view aggView7811131761279022975 as select v1, MIN(v31) as v31 from aggJoin3540627052163280759 group by v1;
create or replace view aggJoin8742946350448295362 as select country_code as v3, v31 from company_name as cn, aggView7811131761279022975 where cn.id=aggView7811131761279022975.v1 and country_code= '[us]';
select MIN(v31) as v31 from aggJoin8742946350448295362;
