create or replace view aggView9046565423087255404 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin3041594361086930786 as select movie_id as v12 from movie_companies as mc, aggView9046565423087255404 where mc.company_id=aggView9046565423087255404.v1;
create or replace view aggView7431231748689515980 as select id as v12 from title as t;
create or replace view aggJoin2963964513268476625 as select v12 from aggJoin3041594361086930786 join aggView7431231748689515980 using(v12);
create or replace view aggView6252774089455236253 as select v12, COUNT(*) as annot from aggJoin2963964513268476625 group by v12;
create or replace view aggJoin6810538076187339522 as select keyword_id as v18, annot from movie_keyword as mk, aggView6252774089455236253 where mk.movie_id=aggView6252774089455236253.v12;
create or replace view aggView6907400577374571111 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2392170852623456127 as select annot from aggJoin6810538076187339522 join aggView6907400577374571111 using(v18);
select SUM(annot) as v31 from aggJoin2392170852623456127;
