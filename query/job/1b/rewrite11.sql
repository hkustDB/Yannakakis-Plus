create or replace view aggView6774429058729270497 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3791983052254506449 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6774429058729270497 where mc.company_type_id=aggView6774429058729270497.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3556445043729273574 as select v15, MIN(v9) as v27 from aggJoin3791983052254506449 group by v15;
create or replace view aggJoin8374212203137789691 as select movie_id as v15, info_type_id as v3, v27 from movie_info_idx as mi_idx, aggView3556445043729273574 where mi_idx.movie_id=aggView3556445043729273574.v15;
create or replace view aggView4967438870352032114 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin6315210040349839613 as select v15, v27 from aggJoin8374212203137789691 join aggView4967438870352032114 using(v3);
create or replace view aggView1868651180583689060 as select v15, MIN(v27) as v27 from aggJoin6315210040349839613 group by v15;
create or replace view aggJoin7900672087866403219 as select title as v16, production_year as v19, v27 from title as t, aggView1868651180583689060 where t.id=aggView1868651180583689060.v15 and production_year<=2010 and production_year>=2005;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin7900672087866403219;
