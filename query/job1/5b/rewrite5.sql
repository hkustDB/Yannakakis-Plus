create or replace view aggView2091875984576180757 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin2554693444568100628 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView2091875984576180757 where mi.movie_id=aggView2091875984576180757.v15 and info IN ('USA','America');
create or replace view aggView7323700416591430591 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5489430602156634509 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7323700416591430591 where mc.company_type_id=aggView7323700416591430591.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView1720150005860170627 as select v15 from aggJoin5489430602156634509 group by v15;
create or replace view aggJoin1237306748532863306 as select v3, v13, v27 as v27 from aggJoin2554693444568100628 join aggView1720150005860170627 using(v15);
create or replace view aggView8757735469351654794 as select id as v3 from info_type as it;
create or replace view aggJoin3161268230887073777 as select v27 from aggJoin1237306748532863306 join aggView8757735469351654794 using(v3);
select MIN(v27) as v27 from aggJoin3161268230887073777;
