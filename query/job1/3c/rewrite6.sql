create or replace view aggView2534434697455554881 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin4190221753527070847 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView2534434697455554881 where mk.movie_id=aggView2534434697455554881.v12;
create or replace view aggView8918948759093988981 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin6871276899874008326 as select v1, v24 as v24 from aggJoin4190221753527070847 join aggView8918948759093988981 using(v12);
create or replace view aggView7676857947428065649 as select v1, MIN(v24) as v24 from aggJoin6871276899874008326 group by v1;
create or replace view aggJoin4358596789600343009 as select keyword as v2, v24 from keyword as k, aggView7676857947428065649 where k.id=aggView7676857947428065649.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin4358596789600343009;
select sum(v24) from res;