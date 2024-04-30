create or replace view aggView7118374890224088342 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1885483076503054927 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7118374890224088342 where mc.company_type_id=aggView7118374890224088342.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView6328331531910370843 as select v15 from aggJoin1885483076503054927 group by v15;
create or replace view aggJoin8042224324694663505 as select id as v15, title as v16, production_year as v19 from title as t, aggView6328331531910370843 where t.id=aggView6328331531910370843.v15 and production_year>2010;
create or replace view aggView8077806435713979478 as select v15, MIN(v16) as v27 from aggJoin8042224324694663505 group by v15;
create or replace view aggJoin6010030552616197503 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView8077806435713979478 where mi.movie_id=aggView8077806435713979478.v15 and info IN ('USA','America');
create or replace view aggView4670403958091524194 as select id as v3 from info_type as it;
create or replace view aggJoin8923154928703777011 as select v27 from aggJoin6010030552616197503 join aggView4670403958091524194 using(v3);
select MIN(v27) as v27 from aggJoin8923154928703777011;
