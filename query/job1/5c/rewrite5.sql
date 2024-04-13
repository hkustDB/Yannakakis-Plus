create or replace view aggView3689206176798062617 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin3374614978696678227 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView3689206176798062617 where mi.movie_id=aggView3689206176798062617.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView1556519758557539708 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1897431163202605608 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1556519758557539708 where mc.company_type_id=aggView1556519758557539708.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView8029510661966343095 as select v15 from aggJoin1897431163202605608 group by v15;
create or replace view aggJoin568279644517485483 as select v3, v13, v27 as v27 from aggJoin3374614978696678227 join aggView8029510661966343095 using(v15);
create or replace view aggView8909378693837822678 as select id as v3 from info_type as it;
create or replace view aggJoin5124193685186486310 as select v27 from aggJoin568279644517485483 join aggView8909378693837822678 using(v3);
select MIN(v27) as v27 from aggJoin5124193685186486310;
