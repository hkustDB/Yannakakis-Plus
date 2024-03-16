create or replace view aggView7204329600360081380 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin5094530288982130587 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView7204329600360081380 where mi.movie_id=aggView7204329600360081380.v15 and info IN ('USA','America');
create or replace view aggView8491338644193095012 as select id as v3 from info_type as it;
create or replace view aggJoin8894733626605657755 as select v15, v13, v27 from aggJoin5094530288982130587 join aggView8491338644193095012 using(v3);
create or replace view aggView2612738762863091557 as select v15, MIN(v27) as v27 from aggJoin8894733626605657755 group by v15;
create or replace view aggJoin7046617067303235636 as select company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView2612738762863091557 where mc.movie_id=aggView2612738762863091557.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView6928534718024612394 as select v1, MIN(v27) as v27 from aggJoin7046617067303235636 group by v1;
create or replace view aggJoin2709051541706142800 as select kind as v2, v27 from company_type as ct, aggView6928534718024612394 where ct.id=aggView6928534718024612394.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin2709051541706142800;
