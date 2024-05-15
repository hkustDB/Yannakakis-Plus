create or replace view aggView8560037574209727012 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin998666821113020960 as select movie_id as v15 from movie_info_idx as mi_idx, aggView8560037574209727012 where mi_idx.info_type_id=aggView8560037574209727012.v3;
create or replace view aggView262241085768411697 as select v15 from aggJoin998666821113020960 group by v15;
create or replace view aggJoin3487378556192814801 as select id as v15, title as v16, production_year as v19 from title as t, aggView262241085768411697 where t.id=aggView262241085768411697.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView3218514996025885427 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin3487378556192814801 group by v15;
create or replace view aggJoin2686556348798736603 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView3218514996025885427 where mc.movie_id=aggView3218514996025885427.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView263137276208521637 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4614764070100486104 as select v9, v28, v29 from aggJoin2686556348798736603 join aggView263137276208521637 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4614764070100486104;
