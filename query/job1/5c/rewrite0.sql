create or replace view aggView6205562875954015231 as select id as v3 from info_type as it;
create or replace view aggJoin7897942998487306671 as select movie_id as v15, info as v13 from movie_info as mi, aggView6205562875954015231 where mi.info_type_id=aggView6205562875954015231.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView8590621679254373849 as select v15 from aggJoin7897942998487306671 group by v15;
create or replace view aggJoin2316119271771819354 as select id as v15, title as v16 from title as t, aggView8590621679254373849 where t.id=aggView8590621679254373849.v15 and production_year>1990;
create or replace view aggView6111115590292355587 as select v15, MIN(v16) as v27 from aggJoin2316119271771819354 group by v15;
create or replace view aggJoin3442999451557453164 as select company_type_id as v1, v27 from movie_companies as mc, aggView6111115590292355587 where mc.movie_id=aggView6111115590292355587.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView582394428454059387 as select v1, MIN(v27) as v27 from aggJoin3442999451557453164 group by v1;
create or replace view aggJoin5808880816875696729 as select v27 from company_type as ct, aggView582394428454059387 where ct.id=aggView582394428454059387.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin5808880816875696729;
