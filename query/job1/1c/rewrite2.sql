create or replace view aggView2331800858259700175 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin5507038906368720976 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView2331800858259700175 where mi_idx.movie_id=aggView2331800858259700175.v15;
create or replace view aggView5797932657075232979 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin5389670828734037781 as select v15, v28, v29 from aggJoin5507038906368720976 join aggView5797932657075232979 using(v3);
create or replace view aggView8665680343241798088 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin5389670828734037781 group by v15;
create or replace view aggJoin3090224069798627628 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView8665680343241798088 where mc.movie_id=aggView8665680343241798088.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7666921302477215476 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2508637232536269928 as select v9, v28, v29 from aggJoin3090224069798627628 join aggView7666921302477215476 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2508637232536269928;
