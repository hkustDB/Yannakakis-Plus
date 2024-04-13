create or replace view aggView4578138239035752628 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin598832340577007999 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView4578138239035752628 where mi.movie_id=aggView4578138239035752628.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView1415789132059913964 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6844351333870961161 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1415789132059913964 where mc.company_type_id=aggView1415789132059913964.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView7916248842301220225 as select v15 from aggJoin6844351333870961161 group by v15;
create or replace view aggJoin2323081463555933533 as select v3, v13, v27 as v27 from aggJoin598832340577007999 join aggView7916248842301220225 using(v15);
create or replace view aggView5683384046493069958 as select id as v3 from info_type as it;
create or replace view aggJoin8239945870140921894 as select v27 from aggJoin2323081463555933533 join aggView5683384046493069958 using(v3);
select MIN(v27) as v27 from aggJoin8239945870140921894;
