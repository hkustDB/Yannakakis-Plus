create or replace view aggView1720250248887383794 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4950655012746528549 as select movie_id as v12 from movie_keyword as mk, aggView1720250248887383794 where mk.keyword_id=aggView1720250248887383794.v1;
create or replace view aggView7095535253033652392 as select v12 from aggJoin4950655012746528549 group by v12;
create or replace view aggJoin8911106195878518633 as select movie_id as v12, info as v7 from movie_info as mi, aggView7095535253033652392 where mi.movie_id=aggView7095535253033652392.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView5187931121341577669 as select v12 from aggJoin8911106195878518633 group by v12;
create or replace view aggJoin4954907792382364773 as select title as v13 from title as t, aggView5187931121341577669 where t.id=aggView5187931121341577669.v12 and production_year>2005;
select MIN(v13) as v24 from aggJoin4954907792382364773;
