create or replace view aggView942229169303090041 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin6195242403299173344 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView942229169303090041 where mi_idx.movie_id=aggView942229169303090041.v15;
create or replace view aggView6399531701914189385 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin4637735804728314484 as select v15, v28, v29 from aggJoin6195242403299173344 join aggView6399531701914189385 using(v3);
create or replace view aggView3359241745308121471 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin4637735804728314484 group by v15;
create or replace view aggJoin3088633913909479571 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView3359241745308121471 where mc.movie_id=aggView3359241745308121471.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7079314883184228302 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin750729528836656668 as select v9, v28, v29 from aggJoin3088633913909479571 join aggView7079314883184228302 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin750729528836656668;
