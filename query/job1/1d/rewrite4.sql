create or replace view aggView8383838944522070806 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8638612712375387626 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8383838944522070806 where mc.company_type_id=aggView8383838944522070806.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1425716977798670355 as select v15, MIN(v9) as v27 from aggJoin8638612712375387626 group by v15;
create or replace view aggJoin910543275714800448 as select movie_id as v15, info_type_id as v3, v27 from movie_info_idx as mi_idx, aggView1425716977798670355 where mi_idx.movie_id=aggView1425716977798670355.v15;
create or replace view aggView5059202811308477832 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin4983287013592973486 as select v15, v27 from aggJoin910543275714800448 join aggView5059202811308477832 using(v3);
create or replace view aggView467014182918299115 as select v15, MIN(v27) as v27 from aggJoin4983287013592973486 group by v15;
create or replace view aggJoin2625679666877913388 as select title as v16, production_year as v19, v27 from title as t, aggView467014182918299115 where t.id=aggView467014182918299115.v15 and production_year>2000;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin2625679666877913388;
