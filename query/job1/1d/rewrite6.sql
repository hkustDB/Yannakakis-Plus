create or replace view aggView7984930197082512022 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin5833765674204906842 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView7984930197082512022 where mc.movie_id=aggView7984930197082512022.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3558367278750348581 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin4856702228338152290 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3558367278750348581 where mi_idx.info_type_id=aggView3558367278750348581.v3;
create or replace view aggView8031517292232519139 as select v15 from aggJoin4856702228338152290 group by v15;
create or replace view aggJoin2735815743438382524 as select v1, v9, v28 as v28, v29 as v29 from aggJoin5833765674204906842 join aggView8031517292232519139 using(v15);
create or replace view aggView1179378788455594431 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2672681287769800496 as select v9, v28, v29 from aggJoin2735815743438382524 join aggView1179378788455594431 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2672681287769800496;
