create or replace view semiJoinView125919844826979537 as select movie_id as v12, company_id as v1 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView8805372416460437364 as select movie_id as v12, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView4796312870369617153 as select v12, v1 from semiJoinView125919844826979537 where (v12) in (select (v12) from semiJoinView8805372416460437364);
create or replace view semiJoinView7677604297595801134 as select id as v12, title as v20 from title AS t where (id) in (select (v12) from semiJoinView4796312870369617153);
create or replace view tAux71 as select v20 from semiJoinView7677604297595801134;
select distinct v20 from tAux71;
