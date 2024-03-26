create or replace view aggView3133492725623396780 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5969657932390294475 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3133492725623396780 where mc.company_type_id=aggView3133492725623396780.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3018969506328375154 as select v15, MIN(v9) as v27 from aggJoin5969657932390294475 group by v15;
create or replace view aggJoin2351799271484012795 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView3018969506328375154 where t.id=aggView3018969506328375154.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView6266187390294923920 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin8632364935992417012 as select movie_id as v15 from movie_info_idx as mi_idx, aggView6266187390294923920 where mi_idx.info_type_id=aggView6266187390294923920.v3;
create or replace view aggView2052469845190016644 as select v15 from aggJoin8632364935992417012 group by v15;
create or replace view aggJoin2684059798130866842 as select v16, v19, v27 as v27 from aggJoin2351799271484012795 join aggView2052469845190016644 using(v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin2684059798130866842;
