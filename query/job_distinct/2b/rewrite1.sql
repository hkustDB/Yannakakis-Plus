create or replace view semiJoinView8972328401300069103 as select movie_id as v12, company_id as v1 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[nl]');
create or replace view semiJoinView6548611161928356654 as select movie_id as v12, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView1036816253809026160 as select v12, v1 from semiJoinView8972328401300069103 where (v12) in (select (v12) from semiJoinView6548611161928356654);
create or replace view semiJoinView660654134540991238 as select id as v12, title as v20 from title AS t where (id) in (select (v12) from semiJoinView1036816253809026160);
create or replace view tAux56 as select v20 from semiJoinView660654134540991238;
select distinct v20 from tAux56;
