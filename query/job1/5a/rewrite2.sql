create or replace view aggView1292758764387940574 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin6755222092363521369 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView1292758764387940574 where mi.movie_id=aggView1292758764387940574.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView4638806616649488343 as select id as v3 from info_type as it;
create or replace view aggJoin211175013043096214 as select v15, v13, v27 from aggJoin6755222092363521369 join aggView4638806616649488343 using(v3);
create or replace view aggView5030000969274129167 as select v15, MIN(v27) as v27 from aggJoin211175013043096214 group by v15;
create or replace view aggJoin8397727058621130404 as select company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView5030000969274129167 where mc.movie_id=aggView5030000969274129167.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView6978791189837661082 as select v1, MIN(v27) as v27 from aggJoin8397727058621130404 group by v1;
create or replace view aggJoin7889015450348198070 as select kind as v2, v27 from company_type as ct, aggView6978791189837661082 where ct.id=aggView6978791189837661082.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin7889015450348198070;
