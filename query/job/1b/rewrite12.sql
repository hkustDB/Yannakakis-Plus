create or replace view aggView1012099259671745620 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin7018583286697642460 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView1012099259671745620 where mi_idx.movie_id=aggView1012099259671745620.v15;
create or replace view aggView4041332554611070718 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8976275854358898915 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4041332554611070718 where mc.company_type_id=aggView4041332554611070718.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8233771632929311633 as select v15, MIN(v9) as v27 from aggJoin8976275854358898915 group by v15;
create or replace view aggJoin3026924771679344387 as select v3, v28 as v28, v29 as v29, v27 from aggJoin7018583286697642460 join aggView8233771632929311633 using(v15);
create or replace view aggView5823919487956787739 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin3026924771679344387 group by v3;
create or replace view aggJoin1820046886579162888 as select info as v4, v28, v29, v27 from info_type as it, aggView5823919487956787739 where it.id=aggView5823919487956787739.v3 and info= 'bottom 10 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1820046886579162888;
