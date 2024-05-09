create or replace view aggView5104355416631910647 as select id as v8 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7068865042990652884 as select movie_id as v23 from movie_keyword as mk, aggView5104355416631910647 where mk.keyword_id=aggView5104355416631910647.v8;
create or replace view aggView7567431175889050262 as select v23, COUNT(*) as annot from aggJoin7068865042990652884 group by v23;
create or replace view aggJoin5239044525835568089 as select id as v23, production_year as v27, annot from title as t, aggView7567431175889050262 where t.id=aggView7567431175889050262.v23 and production_year>2000;
create or replace view aggView6868158117492641567 as select v23, SUM(annot) as annot from aggJoin5239044525835568089 group by v23;
create or replace view aggJoin350971366338379646 as select person_id as v14, annot from cast_info as ci, aggView6868158117492641567 where ci.movie_id=aggView6868158117492641567.v23;
create or replace view aggView1998737794920809154 as select v14, SUM(annot) as annot from aggJoin350971366338379646 group by v14;
create or replace view aggJoin1512745808572561359 as select annot from name as n, aggView1998737794920809154 where n.id=aggView1998737794920809154.v14 and name LIKE '%Downey%Robert%';
select SUM(annot) as v35 from aggJoin1512745808572561359;
