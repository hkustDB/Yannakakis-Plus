create or replace view semiJoinView2681746550514787545 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view semiJoinView7938516708561798087 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info AS mi where (info_type_id) in (select (id) from info_type AS it) and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view semiJoinView7096850526063248887 as select v15, v3, v13 from semiJoinView7938516708561798087 where (v15) in (select (v15) from semiJoinView2681746550514787545);
create or replace view semiJoinView5418843486738983081 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView7096850526063248887) and production_year>2005;
create or replace view tAux78 as select v16 from semiJoinView5418843486738983081;
select distinct v16 from tAux78;
