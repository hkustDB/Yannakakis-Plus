create or replace view aggView7652563272524211271 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3424359173041788526 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7652563272524211271 where mc.company_type_id=aggView7652563272524211271.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView6035239284184806590 as select v15, MIN(v9) as v27 from aggJoin3424359173041788526 group by v15;
create or replace view aggJoin3860753815126567877 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView6035239284184806590 where t.id=aggView6035239284184806590.v15 and production_year>2000;
create or replace view aggView5219038352914293888 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin3860753815126567877 group by v15;
create or replace view aggJoin1351118311569394050 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView5219038352914293888 where mi_idx.movie_id=aggView5219038352914293888.v15;
create or replace view aggView1414401301910728263 as select v3, MIN(v27) as v27, MIN(v28) as v28, MIN(v29) as v29 from aggJoin1351118311569394050 group by v3;
create or replace view aggJoin5814613109302007010 as select v27, v28, v29 from info_type as it, aggView1414401301910728263 where it.id=aggView1414401301910728263.v3 and info= 'bottom 10 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5814613109302007010;
